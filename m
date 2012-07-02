From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 02 Jul 2012 16:24:41 +0100
Subject: [PATCH 11/14] usb: otg: Enable probing of the ab8500 during a
 Device Tree boot
In-Reply-To: <1339428307-3850-12-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-12-git-send-email-lee.jones@linaro.org>
Message-ID: <4FF1BD39.8020800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 16:25, Lee Jones wrote:
> Without this patch, if Device Tree is enabled the AB8500 USB OTG driver
> wouldn't get probed at all, as there is no reference to it from platform
> code. This patch ensures the driver is probed during normal DT start-up.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/usb/otg/ab8500-usb.c |    6 ++++++
>   1 file changed, 6 insertions(+)

Please don't take this patch now, it was been superseded.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
