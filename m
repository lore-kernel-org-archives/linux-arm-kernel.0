From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Jun 2016 15:38:03 +0100
Subject: [v3 PATCH] arm64: kasan: instrument user memory access API
In-Reply-To: <1465422056-20531-1-git-send-email-yang.shi@linaro.org>
References: <1465422056-20531-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20160621143802.GB14542@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 02:40:56PM -0700, Yang Shi wrote:
> The upstream commit 1771c6e1a567ea0ba2cccc0a4ffe68a1419fd8ef
> ("x86/kasan: instrument user memory access API") added KASAN instrument to
> x86 user memory access API, so added such instrument to ARM64 too.
> 
> Define __copy_to/from_user in C in order to add kasan_check_read/write call,
> rename assembly implementation to __arch_copy_to/from_user.
> 
> Tested by test_kasan module.
> 
> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Yang Shi <yang.shi@linaro.org>

Queued for 4.8. Thanks.

-- 
Catalin
