From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 09:51:26 +0800
Subject: [PATCH v4 4/4] mmc: sdhci-imx-esdhc: convert to use pinctrl
 subsystem
In-Reply-To: <CACRpkdbE=fFhTr=MyD-2dgV=W07Kb-T+ax4dgdjZ8ONzoz3K7A@mail.gmail.com>
References: <1335529578-14507-1-git-send-email-b29396@freescale.com>
 <1335529578-14507-4-git-send-email-b29396@freescale.com>
 <CACRpkdbE=fFhTr=MyD-2dgV=W07Kb-T+ax4dgdjZ8ONzoz3K7A@mail.gmail.com>
Message-ID: <20120502015124.GP2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 01:12:58AM +0200, Linus Walleij wrote:
> If I cannot apply it there are two ways to proceed:
> 1. Wait for next merge window
> 2. Pull pinctrl into i.MX tree
> 
Yes, if we would not wait for next merge window, I prefer to ask Arnd,
Olof to pull pinctrl into arm-soc as a dependency and we convert imx
drivers to the subsystem in there.

BTW, this patch should be split into two.  Adding dummy pinctrl for
imx should be one patch, and sdhci-imx-esdhc should be separate one.
And we may want to come up a series to convert all outstanding imx
driver to use pinctrl API, one patch for one driver with subsystem
maintainer Cc on the corresponding driver patch.

-- 
Regards,
Shawn
