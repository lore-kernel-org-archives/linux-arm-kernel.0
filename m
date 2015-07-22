From: olof@lixom.net (Olof Johansson)
Date: Wed, 22 Jul 2015 16:25:43 -0700
Subject: [GIT PULL 1/3] omap dts changes for v4.3, part2
In-Reply-To: <55af6598.225c460a.382ab.1e97SMTPIN_ADDED_BROKEN@mx.google.com>
References: <55af6598.225c460a.382ab.1e97SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20150722232543.GA2909@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 02:41:16AM -0700, Tony Lindgren wrote:
> The following changes since commit 80edaaead3687b47ba3760588306937439ebd7bd:
> 
>   ARM: dts: am335x-evm: Switch using simple-audio-card for audio support (2015-07-14 04:28:25 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/dt-pt2
> 
> for you to fetch changes up to f9d50fef4b6447527c2be1ad07499221c2511391:
> 
>   ARM: OMAP2+: omap3-pandora: add wifi support (2015-07-21 04:07:42 -0700)
> 
> ----------------------------------------------------------------
> More omap dts changes for v4.3 merge window:
> 
> - Add missing devices for pandora. Note that we're adding wl1251
>   WLAN and LCD backlight support for now using legacy pdata as that
>   allows us to drop the legacy board file for pandora in another
>   series of patches
> 
> - Enable power button support for omap5-uevm
> 
> - Add aliases for am437x UARTs
> 
> - Add support for phyCORE phyBOARD-WEGA-AM335x rdk and
>   phyCORE-AM335x SoM
> 
> - Use u16 values for tsc2046 on omap3-lilly

Merged, thanks!


-Olof
