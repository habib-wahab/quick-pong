#include "player_touch_handler.h"

#include <QDateTime>
#include <QtMath>

PlayerTouchHandler::PlayerTouchHandler(QQuickItem *parent) : QQuickItem(parent)
{
    setAcceptedMouseButtons(Qt::LeftButton);
    setAcceptTouchEvents(true);
}

void PlayerTouchHandler::touchEvent(QTouchEvent *event)
{
    if (event->points().isEmpty()) {
        return;
    }

    const QTouchEvent::TouchPoint &touch = event->points().first();
    qreal currentTime = QDateTime::currentMSecsSinceEpoch() / 1000.0;

    if (event->type() == QEvent::TouchBegin) {
        m_yOffset = y() - touch.position().y();
        m_lastYPosition = touch.position().y();
        m_lastUpdateTime = currentTime;
    }

    qreal deltaTime = currentTime - m_lastUpdateTime;
    const qreal smoothingFactor = 0.2;
    qreal targetY = touch.position().y() + m_yOffset;
    qreal smoothedY = lerp(y(), targetY, smoothingFactor * deltaTime * 60.0);

    qreal limitY = parentItem()->height() - height();
    qreal boundedY = qBound(0.0, smoothedY, limitY);

    setY(boundedY);

    m_lastYPosition = touch.position().y();
    m_lastUpdateTime = currentTime;

    event->accept();
}

void PlayerTouchHandler::mousePressEvent(QMouseEvent *event)
{
    m_yOffset = y() - event->globalPosition().y();
    event->accept();
}

void PlayerTouchHandler::mouseMoveEvent(QMouseEvent *event)
{
    qreal limitY = this->parentItem()->height() - this->height();
    qreal initialNewY = event->globalPosition().y() + m_yOffset;
    qreal boundedNewY = std::min(std::max(initialNewY, 0.0), limitY);
    setY(boundedNewY);
}

void PlayerTouchHandler::movePaddle(int dy)
{
    m_yOffset += dy;
    setY(y() + dy);
}
