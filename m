From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Dec 2015 15:11:12 +0000
Subject: [PATCH 3/4] arm64: dts: split Foundation model dts to put the
 GIC separately
In-Reply-To: <1444729069-27922-4-git-send-email-andre.przywara@arm.com>
References: <1444729069-27922-1-git-send-email-andre.przywara@arm.com>
 <1444729069-27922-4-git-send-email-andre.przywara@arm.com>
Message-ID: <56684490.8000007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/15 10:37, Andre Przywara wrote:
> The ARMv8 Foundation model can be run with a GICv2 or a GICv3.
> To prepare for the GICv3 version of the .dts without code duplication,
> move most of the nodes of the existing DT (except the GIC) into an
> include file and just keep that include statement and the GIC node in
> the current foundation-v8.dts.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
