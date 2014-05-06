From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 18:48:57 -0700
Subject: [GIT PULL] SOCFPGA DTS updates for 3.16, v2
In-Reply-To: <1399329971-32027-1-git-send-email-dinguyen@altera.com>
References: <1399329971-32027-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140506014857.GC4701@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 05:46:11PM -0500, dinguyen at altera.com wrote:
> Hi Arnd, Kevin and Olof,
> 
> Please consider pulling in these patches for v3.16. This is version 2 of the
> original SOCFPGA DTS pull request for v3.16. This new tag omits the following
> patches:
> 
> ARM: dts: socfpga: add gpio pieces -> Pending further discussion.
> dt: bindings: Typo s/clocks-names/clock-names/g -> Already in Grant Likely's tree.
> 
> Thanks,
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dt-updates-for-3.16_v2
> 
> for you to fetch changes up to 4665804f4f90f49b4a83371cca828230ccac99b1:
> 
>   ARM: socfpga: dts: Add div-reg to the main_pll clocks (2014-05-05 17:35:10 -0500)
> 
> ----------------------------------------------------------------
> dts: socfpga: general updates for the socfpga platform
> 
> Mostly DTS additions to the SOCFPGA platform from Steffan Trumtrar, and a
> couple of device tree documentation updates/typo fix.
> 
> This one does not have the GPIO binding patch, as that is pending further
> discussion.
> 
> ----------------------------------------------------------------
> Dinh Nguyen (4):
>       ARM: socfpga: dts: add eeprom and rtc on i2c0
>       ARM: socfpga: dts: Remove hard coded clock-frequency property
>       ARM: socfpga: dts: Add DTS entries for USB
>       ARM: socfpga: dts: Add div-reg to the main_pll clocks
> 
> Steffen Trumtrar (10):
>       ARM: socfpga: dts: fix pdma interrupt
>       ARM: socfpga: dts: add remaining interrupts for pdma
>       ARM: socfpga: dts: add i2c busses

Hi, this patch has an artifact in it:

+>>>>>>> 11886cc... ARM: socfpga: dts: add i2c busses

Seems to have happened at rebase, perhaps. Please double-check for these by
building before you send pull requests, please. :)


-Olof
