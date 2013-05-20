From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 14:19:40 +0200
Subject: [PATCH 20/39] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbhzdPGRPFvcSupCJ_vYCdFOnbM-vhp60f9A5Q+jxrP=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> For all ux500 based platforms the maximum number of end-points are used.
> Move this knowledge into the driver so we can relinquish the burden from
> platform data. This also removes quite a bit of complexity from the driver
> and will aid us when we come to enable the driver for Device Tree.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I have now gone over and collected ACKs etc for the patches up until here.

Now you need Felipe's consent to proceed with the MUSB changes
through my tree.

Yours,
Linus Walleij
