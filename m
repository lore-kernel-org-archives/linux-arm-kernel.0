From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 23:39:45 +0200
Subject: [PATCH 11/14] usb: otg: Enable probing of the ab8500 during a
 Device Tree boot
In-Reply-To: <1339428307-3850-12-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-12-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbJzZRXNqy0wSO4cw0eZCys8YiT=5xnN8E61S+7q+obcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Without this patch, if Device Tree is enabled the AB8500 USB OTG driver
> wouldn't get probed at all, as there is no reference to it from platform
> code. This patch ensures the driver is probed during normal DT start-up.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
