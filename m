From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 24 Dec 2010 12:37:43 +0900
Subject: [PATCH] drivers: ld9040 amoled driver support
In-Reply-To: <1292826187-17758-1-git-send-email-dh09.lee@samsung.com>
References: <1292826187-17758-1-git-send-email-dh09.lee@samsung.com>
Message-ID: <20101224033743.GK28151@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 03:23:07PM +0900, Donghwa Lee wrote:
> This patch is ld9040 amoled panel driver using RGB interface. I resend it
> because there was no comment.
> 
> ld9040 panel is 4 ~ 4.5 inch real WVGA model. It is similar to s6e63m0 panel
> driver and use spi gpio to send panel information.
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> 
The backlight subsystem alleges to have a maintainer, so I'd rather avoid
taking backlight-related patches through the fbdev tree. I can of course
take them with Richard's Acked-by, though.
