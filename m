From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Aug 2015 17:57:01 +0100
Subject: [PATCH 2/5] ACPI / ARM64: remove usage of
 BAD_MADT_ENTRY/BAD_MADT_GICC_ENTRY
In-Reply-To: <1438894770-31163-3-git-send-email-al.stone@linaro.org>
References: <1438894770-31163-1-git-send-email-al.stone@linaro.org>
 <1438894770-31163-3-git-send-email-al.stone@linaro.org>
Message-ID: <20150807165701.GI19308@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 02:59:27PM -0600, Al Stone wrote:
> Now that we have introduced the bad_madt_entry() function, and that
> function is being invoked in acpi_table_parse_madt() for us, there
> is no longer any need to use the BAD_MADT_ENTRY macro, or in the case
> of arm64, the BAD_MADT_GICC_ENTRY, too.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
