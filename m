From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Nov 2010 18:13:22 +0000
Subject: [PATCH 1/5] ARM: l2x0: Add aux control register bitfields
In-Reply-To: <1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1290190402.14953.10.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-19 at 17:31 +0000, Santosh Shilimkar wrote:
> This patch adds the PL310 Auxiliary Control Register bitfields
> so that SOC's can use these bit fields to construct the AUXCTRL
> value to be passed/programmed instead of hardcoding it.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
