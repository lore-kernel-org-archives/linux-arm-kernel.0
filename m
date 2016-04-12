From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Apr 2016 12:33:22 -0700
Subject: [GIT PULL] omap fixes against v4.6-rc1
In-Reply-To: <20160401160115.GM9329@atomide.com>
References: <20160401160115.GM9329@atomide.com>
Message-ID: <20160412193322.GB5588@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 09:01:15AM -0700, Tony Lindgren wrote:
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/fixes-rc1
> 
> for you to fetch changes up to 6f40fed1c911f218e1e189a404b26ef19effabb5:
> 
>   ARM: dts: am335x-baltos-ir5221: fix cpsw_emac0 link type (2016-03-30 14:33:22 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps against v4.6-rc1. Mostly minor fixes for the newer
> SoCs with few board fixes and a fix for a long time hwmod bug:
> 
> - Fix cpsw_emac0 link type for baltos-ir5221
> 
> - Fix interrupt type for TWD
> 
> - Fix edma memcpy channel allocation for am43x
> 
> - Fix am43x-epos sycntimer32k by using the correct assigned clock
> 
> - Fix interconnect barrier for dra7
> 
> - Fix a long time hwmod bug for updating sysconfig register properly
> 
> - Fix flakey booting on dm814x where USB reset needs a delay
> 
> And there is one minor change that is not strictly a fix, but is
> good to have for proper hardware detection:
> 
> - Detect dra7 silicon revision 2.0 properly

Merged, thanks.


-Olof
