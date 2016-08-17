From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Wed, 17 Aug 2016 18:48:14 +0300
Subject: [PATCH] mm, kasan: Update kasan docs to indicate arm64 support
In-Reply-To: <1471365031-27115-1-git-send-email-labbott@redhat.com>
References: <1471365031-27115-1-git-send-email-labbott@redhat.com>
Message-ID: <1e8f2aa7-78a6-f39a-640c-015cc279e2bc@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/16/2016 07:30 PM, Laura Abbott wrote:
> KASAN has been supported on arm64 since 39d114ddc682 ("arm64: add KASAN
> support"). Update the docs to indicate this.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

> ---
>  Documentation/kasan.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/kasan.txt b/Documentation/kasan.txt
> index 7dd95b3..d167220 100644
> --- a/Documentation/kasan.txt
> +++ b/Documentation/kasan.txt
> @@ -12,7 +12,7 @@ KASAN uses compile-time instrumentation for checking every memory access,
>  therefore you will need a GCC version 4.9.2 or later. GCC 5.0 or later is
>  required for detection of out-of-bounds accesses to stack or global variables.
>  
> -Currently KASAN is supported only for x86_64 architecture.
> +Currently KASAN is supported only for x86_64 and arm64 architecture.
>  
>  1. Usage
>  ========
> 
