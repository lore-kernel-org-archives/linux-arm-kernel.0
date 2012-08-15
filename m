From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 14:35:30 +0000
Subject: [PATCH v2 22/31] arm64: Floating point and SIMD
In-Reply-To: <1344966752-16102-23-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-23-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151435.30646.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:
> This patch adds support for FP/ASIMD register bank saving and restoring
> during context switch and FP exception handling to generate SIGFPE.
> There are 32 128-bit registers and the context switching is currently
> done non-lazily. Benchmarks on real hardware are required before
> implementing lazy FP state saving/restoring.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
