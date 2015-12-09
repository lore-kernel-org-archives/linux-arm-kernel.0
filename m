From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Dec 2015 15:10:20 +0000
Subject: [PATCH 1/4] arm64: dts: prepare foundation-v8.dts to cope with
 GICv3
In-Reply-To: <1444729069-27922-2-git-send-email-andre.przywara@arm.com>
References: <1444729069-27922-1-git-send-email-andre.przywara@arm.com>
 <1444729069-27922-2-git-send-email-andre.przywara@arm.com>
Message-ID: <5668445C.9070702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/15 10:37, Andre Przywara wrote:
> To prepare the ARM foundation model to support GICv3, we adjust
> the #address-cells property of the current GICv2 node to be
> compatible with the two cells required for GICv3 later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
