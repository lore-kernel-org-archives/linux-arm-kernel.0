From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jul 2015 12:06:24 +0100
Subject: [PATCH 1/5] arm64: kernel: preparatory: Move config_sctlr_el1
In-Reply-To: <1437062519-18883-2-git-send-email-james.morse@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
 <1437062519-18883-2-git-send-email-james.morse@arm.com>
Message-ID: <20150717110624.GC13712@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 05:01:55PM +0100, James Morse wrote:
> Later patches need config_sctlr_el1 to set/clear bits in the sctlr_el1
> register.
> 
> This patch moves this function into header a file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
