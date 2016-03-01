From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Mar 2016 10:00:47 -0800
Subject: [GIT PULL] ARM: OMAP2+: second set of hwmod changes for v4.6
In-Reply-To: <alpine.DEB.2.02.1603010958120.14948@utopia.booyaka.com>
References: <alpine.DEB.2.02.1603010958120.14948@utopia.booyaka.com>
Message-ID: <20160301180046.GY13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [160301 01:59]:
> Hi Tony
> 
> The following changes since commit 8fe097a3d99e22355fb8e3bcee59542bf3f46b2d:
> 
>   ARM: DRA7: hwmod: Add reset data for PCIe (2016-02-09 02:18:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.6/omap-hwmod-b
> 
> for you to fetch changes up to 34b4182ce5fd284bff38764f8e73e2160b49d8e9:
> 
>   ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0, tptc1 (2016-03-01 01:55:59 -0700)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: second set of hwmod changes for v4.6
> 
> These patches add RTC support for the AM43xx, and add support for
> the DRA7xx eDMA controller's TPCC, TPTC0, and TPTC1 IP blocks.
> Also included is a workaround for PRCM hardreset control of the DRA7xx
> PCIe subsystem.
> 
> Note that I do not have a DRA7xx board, and therefore cannot
> test any patches for that SoC family.
> 
> Basic build, boot, and PM test logs can be found here:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-b-for-v4.6/20160301021258/

Thanks pulling into omap-for-v4.6/soc.

Regards,

Tony
