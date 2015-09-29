From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 29 Sep 2015 11:26:50 +0100
Subject: [PATCH v3 6/7] clocksource/arm_arch_timer: Convert to ACPI probing
In-Reply-To: <1443451758-22717-7-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150929102650.GE30504@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 03:49:17PM +0100, Marc Zyngier wrote:
> It is now absolutely trivial to convert the arch timer driver to
> use ACPI probing, just like its DT counterpart.
> 
> Let's enjoy another crapectomy.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
