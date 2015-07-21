From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Jul 2015 13:32:26 +0100
Subject: [PATCH v3 1/6] arm64: kernel: Add cpuid_feature_extract_field()
 for 4bit sign extension
In-Reply-To: <1437481411-1595-2-git-send-email-james.morse@arm.com>
References: <1437481411-1595-1-git-send-email-james.morse@arm.com>
 <1437481411-1595-2-git-send-email-james.morse@arm.com>
Message-ID: <20150721123224.GB25887@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 01:23:26PM +0100, James Morse wrote:
> Based on arch/arm/include/asm/cputype.h, this function does the
> shifting and sign extension necessary when accessing cpu feature fields.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Suggested-by: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
