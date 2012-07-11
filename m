From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jul 2012 23:54:23 +0200
Subject: [PATCH 2/2] gpio/omap: add *remove* callback in platform_driver
In-Reply-To: <1341997995-14020-3-git-send-email-tarun.kanti@ti.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
 <1341997995-14020-3-git-send-email-tarun.kanti@ti.com>
Message-ID: <CACRpkdYxE7rj8HHAy3+HbQHW4+WbqK2suggfBqKX=TbhHzraDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 11:13 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:

> Add *remove* callback so that necessary cleanup operations are
> performed when device is unregistered. The device is deleted
> from the list and associated clock handle is released by
> calling clk_put() and irq descriptor is released using the
> irq_free_desc() api.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Looks good, applied.

Yours,
Linus Walleij
