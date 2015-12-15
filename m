From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Dec 2015 15:52:34 +0000
Subject: [PATCH v2 2/4] arm64: dts: Foundation model: increase GICC region
 to allow EOImode=1
In-Reply-To: <1450186598-24504-3-git-send-email-andre.przywara@arm.com>
References: <1450186598-24504-1-git-send-email-andre.przywara@arm.com>
 <1450186598-24504-3-git-send-email-andre.przywara@arm.com>
Message-ID: <56703742.70601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/15 13:36, Andre Przywara wrote:
> The Foundation model GIC mapping is wrong, as the GICC region should
> be 8kB instead of 4kB (the model implements the GICv2 architecture).
> This defect prevents the driver from switching to EOImode==1.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
