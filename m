From: nm@ti.com (Nishanth Menon)
Date: Thu, 19 Sep 2013 10:20:58 -0500
Subject: [PATCH 0/2] ARM: dts: dra7-evm: add support for sd, eMMC
In-Reply-To: <1377525218-7655-1-git-send-email-balajitk@ti.com>
References: <1377525218-7655-1-git-send-email-balajitk@ti.com>
Message-ID: <523B165A.5020006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2013 08:53 AM, Balaji T K wrote:
> Add mmc1, mmc2 dt node to dra7-evm
> 
> Balaji T K (2):
>   ARM: dts: dra7-evm: Add mmc1 node for micro-sd support
>   ARM: dts: dra7-evm: Add mmc2 node for eMMC support
> 
>  arch/arm/boot/dts/dra7-evm.dts |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
Series:

Acked-by: Nishanth Menon <nm@ti.com>

Thanks. this is needed for MMC boot on DRA7 evm.
-- 
Regards,
Nishanth Menon
