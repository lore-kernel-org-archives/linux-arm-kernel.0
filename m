From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Mon, 30 May 2016 11:26:41 +0300
Subject: [v2 PATCH] arm64: kasan: instrument user memory access API
In-Reply-To: <1464382863-11879-1-git-send-email-yang.shi@linaro.org>
References: <1464382863-11879-1-git-send-email-yang.shi@linaro.org>
Message-ID: <574BF941.7090906@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/28/2016 12:01 AM, Yang Shi wrote:
> The upstream commit 1771c6e1a567ea0ba2cccc0a4ffe68a1419fd8ef
> ("x86/kasan: instrument user memory access API") added KASAN instrument to
> x86 user memory access API, so added such instrument to ARM64 too.
> 
> Define __copy_to/from_user in C in order to add kasan_check_read/write call,
> rename assembly implementation to __arch_copy_to/from_user.
> 
> Tested by test_kasan module.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> 

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
