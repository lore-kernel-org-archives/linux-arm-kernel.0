From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 15:04:10 -0700
Subject: [GIT PULL] SOCFPGA DTS updates for 3.16
In-Reply-To: <1398466670-8341-1-git-send-email-dinguyen@altera.com>
References: <1398466670-8341-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140505220410.GI29245@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 05:57:49PM -0500, dinguyen at altera.com wrote:
> Hi Arnd, Kevin and Olof,
> 
> Please consider pulling in these patches for v3.16. These consist mostly of
> DTS updates and a few DTS bindings documentation updates for SOCFPGA.
> 
> Thanks,
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dt-updates-for-3.16
> 
> for you to fetch changes up to 2adecac3f50865b53c060949be4251a486547c48:
> 
>   dt: bindings: Typo s/clocks-names/clock-names/g (2014-04-24 17:52:30 -0500)
> 
> ----------------------------------------------------------------
> dts: socfpga: general updates for the socfpga platform
> 
> Mostly DTS additions to the SOCFPGA platform from Steffan Trumtrar, and a
> couple of device tree documentation updates/typo fix.
> 
> ----------------------------------------------------------------
> Dinh Nguyen (4):
>       ARM: socfpga: dts: add eeprom and rtc on i2c0
>       ARM: socfpga: dts: Remove hard coded clock-frequency property
>       ARM: socfpga: dts: Add DTS entries for USB
>       ARM: socfpga: dts: Add div-reg to the main_pll clocks
> 
> Geert Uytterhoeven (1):
>       dt: bindings: Typo s/clocks-names/clock-names/g
> 
> Sebastian Andrzej Siewior (1):
>       ARM: dts: socfpga: add gpio pieces
> 
> Steffen Trumtrar (10):
>       ARM: socfpga: dts: fix pdma interrupt
>       ARM: socfpga: dts: add remaining interrupts for pdma
>       ARM: socfpga: dts: add i2c busses
>       ARM: socfpga: dts: add can0+1
>       ARM: socfpga: dts: add support for EBV SOCrates
>       ARM: socfpga: dts: add rtc on i2c0 to socrates
>       ARM: socfpga: dts: convert to preprocessor includes
>       Documentation: dt: socfpga: add reset-cells property
>       Documentation: dt: reset: move socfpga-reset
>       ARM: socfpga: dts: add reset-controller

Hi,

I had a comment on the gpio binding, so I replied to the original patch. Let's
see that discussion reach a conclusion before I bring this in.

If you prefer, you can prepare the branch without that patch if you want to
land everything else, and then do a incremental pull request with that patch
(or equivalent patch) once discussion has been settled.


-Olof
