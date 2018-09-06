From: sed@free.fr (Cedric Roux)
Date: Thu, 6 Sep 2018 21:22:20 +0200
Subject: [PATCH] mini2440 MMC correct write protect detection
In-Reply-To: <20180906160124.626l5fgn2cn4veyq@kozik-lap>
References: <85dac0df-2b75-9cc4-fde1-f62136974a1e@free.fr>
 <20180905174513.6w7z5jsc2e6ndntv@kozik-lap>
 <204cf57b-a4f2-76b9-766c-20905596ca4e@free.fr>
 <20180906160124.626l5fgn2cn4veyq@kozik-lap>
Message-ID: <d993bd0c-a69e-8d03-c5e5-d40de363bd95@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2018 06:01 PM, Krzysztof Kozlowski wrote:
> The patch was not patchwork compatible:
>     Applying patch #10587863 using 'git am -s'
>     Description: mini2440 MMC correct write protect detection
>     Applying: mini2440 MMC correct write protect detection
>     error: arm/mach-s3c24xx/mach-mini2440.c: does not exist in index

My bad, sorry. I didn't read carefully
Documentation/process/submitting-patches.rst

> 
> git-am by default expects -p1.
> 
> The preferred and easiest way to generate patches is to use git for your
> work and then just:
>     $ git format-patch -1
>     $ scripts/get_maintainer 000*
>     $ git send-email --to ........  000*
> 
> (the last commands can be even squashed into one but that is just
> optimization).
> 
> If you do not use git, please pay attention to generate proper
> applicable patches.

I'll stick to git for the next ones. Thanks for the quick
tutorial. I'll also try to use the correct prefix in my emails.

Best regards,
C?dric.

> 
> Best regards,
> Krzysztof
> 
