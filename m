From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 22 Aug 2011 16:11:50 -0700
Subject: error: implicit declaration of function 'machine_is_ventana'
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A376A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Commit 46dcfc806a9f6834e6007449eac175f781058c49 "ARM: Update mach-types"
removed the entry for Ventana (2927). In turn, this broke compilation of
sound/soc/tegra/tegra_wm8903.c, since that calls machine_is_ventana().
It looks like the machine is still registered at
http://www.arm.linux.org.uk/developer/machines/. Can you explain what the
removal policy is for arch/arm/tools/mach-types?

Thanks!

-- 
nvpublic
