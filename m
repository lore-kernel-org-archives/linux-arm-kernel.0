From: gerg@snapgear.com (Greg Ungerer)
Date: Wed, 21 Nov 2012 14:57:36 +1000
Subject: Where CONFIG_DRAM_BASE/CONFIG_DRAM_SIZE defined?
In-Reply-To: <slrnkaoc27.2jk.narkewoody@zuhnb712.local.com>
References: <slrnkaoc27.2jk.narkewoody@zuhnb712.local.com>
Message-ID: <50AC5F40.5080805@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 11:38 AM, Woody Wu wrote:
> I found arm code is referring two definitions CONFIG_DRAM_BASE and
> CONFIG_DRAM_SIZE. But I searched through the code, still cannot find
> where they are defined?
>
> Do you know where are they?

arch/arm/Kconfig-nommu

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
