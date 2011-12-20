From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 20 Dec 2011 10:53:28 -0800
Subject: [PATCH] arm/tegra: remove __initdata annotation from pinmux tables
In-Reply-To: <1324402418-20279-1-git-send-email-olof@lixom.net>
References: <1324402418-20279-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92D95@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Tuesday, December 20, 2011 10:34 AM:
> Instead of reshuffling what functions in the pinmux paths should be
> __init and thus could keep references to __initdata, let's just remove
> the annotations for now -- the tables are moving to device tree in the
> next version anyway and the whole subsystem is being wired up. We will
> go back and re-annotate where appropriate once things settle down.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
