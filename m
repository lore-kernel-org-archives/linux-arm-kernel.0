From: nm@ti.com (Nishanth Menon)
Date: Thu, 15 Jan 2015 10:45:11 -0600
Subject: [PATCH] ARM: OMAP: Work around hardcoded interrupts
In-Reply-To: <1421335212-4115-1-git-send-email-marc.zyngier@arm.com>
References: <1421335212-4115-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150115164511.GA21656@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:20-20150115, Marc Zyngier wrote:
> Commit 9a1091ef0017 (irqchip: gic: Support hierarchy irq domain)
nit-picking.... which Tony can handle I think..
checkpatch --strict seems picky and recommends using " " as follows:
Commit 9a1091ef0017 ("irqchip: gic: Support hierarchy irq domain.")

Otherwise,
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
