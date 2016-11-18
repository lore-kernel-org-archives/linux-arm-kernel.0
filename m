From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 16:37:48 -0800
Subject: [GIT PULL] omap fixes for v4.9-rc cycle
In-Reply-To: <582a57e8.0203630a.cc89e.c3f4SMTPIN_ADDED_BROKEN@mx.google.com>
References: <582a57e8.0203630a.cc89e.c3f4SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20161118003748.GC8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 04:33:35PM -0800, Tony Lindgren wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.9/fixes-for-rc-cycle
> 
> for you to fetch changes up to 1bc2f5fac34535aeb3878ce32a762a221be7a851:
> 
>   ARM: dts: omap5: board-common: fix wrong SMPS6 (VDD-DDR3) voltage (2016-11-14 13:03:21 -0800)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v4.9-rc cycle. Except for the omap3 fix for the SoC
> features printed, all these are quite trivial and tiny. The omap5 jack
> detection and gpadc patches are not strictly fixes, but I wanted to get
> binding document typo fixed before it pops up on other boards. The
> gpadc one liner was in the same series and I applied and pushed it out
> already before noticing it could have waited. The list of changes is:
> 
> - Fix omap3 SoC features printed
> 
> - Make sure OMAP_INTERCONNECT is selected for am43xx only configurations
> 
> - Add missing memory node for torpedo
> 
> - Initialize uart4_mask properly to avoid writing garbage to PRM registers
> 
> - Fix NULL pointer dereference for omap4 volt_data
> 
> - Add alias for omap5 gpadc needed by iio drivers
> 
> - Enable omap5 jack headset jack detection and fix it's binding typo
> 
> - Add missing memory node for logicpd-som-lv
> 
> - Fix wrong SMPS6 voltage for VDD-DDR3 for omap5

Merged, thanks!


-Olof
