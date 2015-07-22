From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Jul 2015 15:21:45 +0100
Subject: [PATCH v3 2/5] arm64: introduce VA_START macro - the first
 kernel virtual address.
In-Reply-To: <1437561037-31995-3-git-send-email-a.ryabinin@samsung.com>
References: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
 <1437561037-31995-3-git-send-email-a.ryabinin@samsung.com>
Message-ID: <20150722142145.GB16627@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 01:30:34PM +0300, Andrey Ryabinin wrote:
> In order to not use lengthy (UL(0xffffffffffffffff) << VA_BITS) everywhere,
> replace it with VA_START.
> 
> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
