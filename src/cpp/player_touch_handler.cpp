#include "player_touch_handler.h"

PlayerTouchHandler::PlayerTouchHandler(QQuickItem *parent) : QQuickItem(parent)
{
	setAcceptedMouseButtons(Qt::LeftButton);
	setAcceptTouchEvents(true);
}

void PlayerTouchHandler::touchEvent(QTouchEvent *event)
{
	if(event->points().size() > 0)
	{
		QTouchEvent::TouchPoint touch = event->points().first();
		qreal half_parent_height = this->height() / 2;
		qreal limit_y = this->parentItem()->height() - this->height();
		qreal initial_new_y = touch.position().y() - half_parent_height;
		qreal bounded_new_y = std::min(std::max(initial_new_y, (qreal)0.0), limit_y);
		this->setY(bounded_new_y);
	}
}

void PlayerTouchHandler::mousePressEvent(QMouseEvent *event)
{
	y_offset_ = y() - event->globalPosition().y();
	event->accept();
}

void PlayerTouchHandler::mouseMoveEvent(QMouseEvent *event)
{
	qreal limit_y = this->parentItem()->height() - this->height();
	qreal initial_new_y = event->globalPosition().y() + y_offset_;
	qreal bounded_new_y = std::min(std::max(initial_new_y, (qreal)0.0), limit_y);
	this->setY(bounded_new_y);
}
