#pragma once
#include <QQuickItem>

class PlayerTouchHandler : public QQuickItem
{
    Q_OBJECT

public:
    explicit PlayerTouchHandler(QQuickItem *parent = nullptr);

    Q_INVOKABLE void movePaddle(int dy);

protected:
    void touchEvent(QTouchEvent *event) override;
    void mousePressEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;

private:
    qreal y_offset_;
};
