From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 01:22:24 -0700
Subject: [GIT PULL 3/3] omap sdhci dts changes for v4.18 merge window
In-Reply-To: <pull-1525450571-674978@atomide.com-3>
References: <pull-1525450571-674978@atomide.com>
 <pull-1525450571-674978@atomide.com-3>
Message-ID: <20180514082224.dx63ao3vz3ay5ng5@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 09:17:33AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 3f4028780287ff5a7308f40e10bbba9a42b993aa:
> 
>   mmc: sdhci-omap: Get IODelay values for 3.3v DDR mode (2018-05-03 09:37:13 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/dt-sdhci-signed
> 
> for you to fetch changes up to 24a6f1f65ea567d017c598faf1374ee443f73851:
> 
>   Documentation: ARM: Add new MMC requirements for DRA7/K2G (2018-05-03 10:32:20 -0700)
> 
> ----------------------------------------------------------------
> Device tree changes for omap variants for SDHCI
> 
> This series adds the devicetree configuration needed for pinctrl on
> dra7 variants to use the SDHCI SDIO driver instead of mmc-omap-hs
> driver. To use SDHCI, both the pins and the iodelay needs to be
> configured.
> 
> This series is based on the related SDHCI drivers changes on a branch
> set up by Ulf.

Hi Tony,

Just to make sure Ulf isn't taken by surprise (since I didn't see the initial
agreement of a stable branch), it's a good idea to include him on the pull
request.

Also, the diffstat doesn't take that branch into consideration so it doesn't
match with what I've merged with. Having the URL of Ulf's branch helps, in that
case I'd just merge that branch first and get the dependency documented.


Ulf, does the above sound OK with you, and said branch is 100% guaranteed to
not be rebased?


Thanks,


-Olof
