From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Jul 2015 14:39:39 +0100
Subject: [PATCH v2 2/5] drivers: firmware: psci: move power_state
 handling to generic code
In-Reply-To: <1436375811-10529-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1436375811-10529-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1436375811-10529-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20150709133938.GE20855@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 06:16:48PM +0100, Lorenzo Pieralisi wrote:
> Functions implemented on arm64 to check if a power_state parameter
> is valid and if the power_state implies context loss are not
> arm64 specific and should be moved to generic code so that they
> can be reused on arm systems too.
> 
> This patch moves the functions handling the power_state parameter
> to generic PSCI firmware layer code.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
