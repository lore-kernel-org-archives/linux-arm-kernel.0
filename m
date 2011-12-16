From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Dec 2011 11:48:27 -0800
Subject: [GIT PULL] ARM: OMAP: EHCI/OHCI: convert to runtime PM
In-Reply-To: <alpine.DEB.2.00.1112160447440.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1112160447440.12660@utopia.booyaka.com>
Message-ID: <20111216194827.GJ32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111216 03:20]:
> Hi Tony,
> 
> This series converts the USB EHCI/OHCI code to use runtime PM.  It has 
> multiple hwmods for its omap_device, but Keshava & Partha have promised to 
> post patches to solve that problem for the 3.4 merge window.
> 
> This series has a dependency on the "hwmod_data_devel_3.3" branch, which 
> in turn depends on the "hwmod_data_fixes_3.2rc" branch.

Thanks pulling into ehci branch on top of hwmod branch which is based
on fixes-non-critical-part2.

Regards,

Tony
