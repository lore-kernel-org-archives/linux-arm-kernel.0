From: kgene@kernel.org (Kukjin Kim)
Date: Sun, 16 Nov 2014 10:17:14 +0900
Subject: [PATCH] ARM: dts: Explicitly set dr_mode on exynos5250-snow
In-Reply-To: <CABxcv=k6rkatN0NSq-gkGA+ZS1chS-bcXu=Nxk+Uf=WuPrKR5w@mail.gmail.com>
References: <1415994379-29165-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <CABxcv=k6rkatN0NSq-gkGA+ZS1chS-bcXu=Nxk+Uf=WuPrKR5w@mail.gmail.com>
Message-ID: <00ee01d0013b$0f4ac140$2de043c0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Hello Sjoerd,
> 
Hi,

> On Fri, Nov 14, 2014 at 8:46 PM, Sjoerd Simons
> <sjoerd.simons@collabora.co.uk> wrote:
> > Explicitly set the dr_mode for the dwc3 controller on the
> > Snow board to host mode. This is required to ensure the
> > controller is initialized in the right mode if the kernel is
> > build with USB gadget support.
> 
> The patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Kukjin,
> 
> I think $subject is -rc material since this issue is seen after commit
> 508423b ("ARM: exynos_defconfig: enable USB gadget support") which
> landed in 3.18.
> 
Yeah, you're right. I'll queue this into -fixes for 3.18.

Thanks,
Kukjin
