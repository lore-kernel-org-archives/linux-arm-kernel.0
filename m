From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 20 May 2012 09:38:23 +0800
Subject: [PATCH] mtd: nand: gpmi: fix compile error caused by pinctrl call
In-Reply-To: <CAOesGMhfByBhx9Kn1PhYMoaKfbD8NeOrYHCG5sTkRLDwmPW-MA@mail.gmail.com>
References: <1337432773-24000-1-git-send-email-shawn.guo@linaro.org>
 <CAOesGMhfByBhx9Kn1PhYMoaKfbD8NeOrYHCG5sTkRLDwmPW-MA@mail.gmail.com>
Message-ID: <20120520013821.GI5427@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2012 at 08:11:30AM -0700, Olof Johansson wrote:
> Applied to imx/pinctrl (and next/pinctrl).
> 
Thanks.

> Given that the mxs defconfig doesn't expose this error, would you mind
> adding the driver to the platforms where it makes sense so we get
> build coverage in linux next and for those who use defconfigs to
> provide it?
> 
Yes.  I'm poking my colleague to testing device tree support for the
driver.  If everything works fine, we will enable the driver in
mxs_defconfig, but that will probably be next cycle.

-- 
Regards,
Shawn
