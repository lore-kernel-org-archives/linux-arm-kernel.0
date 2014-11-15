From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 15 Nov 2014 10:27:28 +0100
Subject: [PATCH] ARM: dts: Explicitly set dr_mode on exynos5250-snow
In-Reply-To: <1415994379-29165-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1415994379-29165-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <CABxcv=k6rkatN0NSq-gkGA+ZS1chS-bcXu=Nxk+Uf=WuPrKR5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sjoerd,

On Fri, Nov 14, 2014 at 8:46 PM, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> Explicitly set the dr_mode for the dwc3 controller on the
> Snow board to host mode. This is required to ensure the
> controller is initialized in the right mode if the kernel is
> build with USB gadget support.

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Kukjin,

I think $subject is -rc material since this issue is seen after commit
508423b ("ARM: exynos_defconfig: enable USB gadget support") which
landed in 3.18.

Best regards,
Javier
