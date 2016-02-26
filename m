From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Feb 2016 14:44:59 +0000
Subject: [PATCH v3] arm64: mm: Mark .rodata as RO
In-Reply-To: <1455904232-24053-1-git-send-email-jeremy.linton@arm.com>
References: <1455904232-24053-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <20160226144459.GL4777@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 11:50:32AM -0600, Jeremy Linton wrote:
> Currently the .rodata section is actually still executable when DEBUG_RODATA
> is enabled. This changes that so the .rodata is actually read only, no execute.
> It also adds the .rodata section to the mem_init banner.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Applied. Thanks.

-- 
Catalin
