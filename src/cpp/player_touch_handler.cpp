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

    const QTouchEvent::TouchPoint& touch = event->points().first();

    qreal current_time = QDateTime::currentMSecsSinceEpoch() / 1000.0;

    if (event->type() == QEvent::TouchBegin) {
        m_yOffset = y() - touch.position().y();
        m_lastYPosition = touch.position().y();
        m_lastUpdateTime = current_time;
    }

    qreal delta_time = current_time - m_lastUpdateTime;

    const qreal smoothing_factor = 0.2;
    qreal target_y = touch.position().y() + m_yOffset;
    qreal smoothed_y = lerp(y(), target_y, smoothing_factor * delta_time * 60.0);

    qreal limit_y = parentItem()->height() - height();
    qreal bounded_y = qBound(0.0, smoothed_y, limit_y);

    setY(bounded_y);

    m_lastYPosition = touch.position().y();
    m_lastUpdateTime = current_time;

    event->accept();
}

void PlayerTouchHandler::mousePressEvent(QMouseEvent *event)
{
	m_yOffset = y() - event->globalPosition().y();
	event->accept();
}

void PlayerTouchHandler::mouseMoveEvent(QMouseEvent *event)
{
	qreal limit_y = this->parentItem()->height() - this->height();
	qreal initial_new_y = event->globalPosition().y() + m_yOffset;
	qreal bounded_new_y = std::min(std::max(initial_new_y, (qreal)0.0), limit_y);
	this->setY(bounded_new_y);
}

void PlayerTouchHandler::movePaddle(int dy)
{
    m_yOffset += dy;
    setY(y() + dy);
}
