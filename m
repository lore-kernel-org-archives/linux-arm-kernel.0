From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 4 Jan 2012 15:51:03 -0800
Subject: [PATCH 8/9] arm/tegra: seaboard: add EMC table to device tree
In-Reply-To: <1324599468-12845-9-git-send-email-olof@lixom.net>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-9-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F1590@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Thursday, December 22, 2011 5:18 PM:
> Timings for the T25 version of seaboard, only one memory manufacturer
> and timing table (two speeds).

There exist Seaboards with Tegra20 rather than Tegra25. Should we:
* Rename tegra-seaboard.dts to tegra-seaboard.dtsi
* Create tegra-seaboard-t20.dts and tegra-seaboard-t25.dts which include
  tegra-seaboard.dtsi, and add the EMC tables to the Tegra25 version only?

Are the timings for true Seaboard and the Springbank variant identical?

-- 
nvpublic
