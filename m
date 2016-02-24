From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Feb 2016 10:23:52 +0000
Subject: [PATCH] arm64: Fix misspellings in comments.
In-Reply-To: <1456270006-26035-1-git-send-email-adam.buchbinder@gmail.com>
References: <1456270006-26035-1-git-send-email-adam.buchbinder@gmail.com>
Message-ID: <20160224102351.GB28310@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 03:26:46PM -0800, Adam Buchbinder wrote:
> Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra132.dtsi | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 +-
>  arch/arm64/include/asm/ftrace.h          | 2 +-
>  arch/arm64/include/asm/kvm_arm.h         | 2 +-
>  arch/arm64/include/asm/kvm_host.h        | 4 ++--
>  arch/arm64/kernel/fpsimd.c               | 2 +-
>  arch/arm64/kernel/kgdb.c                 | 4 ++--
>  arch/arm64/kernel/signal32.c             | 2 +-
>  arch/arm64/lib/memcmp.S                  | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)

[...]

> diff --git a/arch/arm64/lib/memcmp.S b/arch/arm64/lib/memcmp.S
> index ffbdec0..dc5f17c 100644
> --- a/arch/arm64/lib/memcmp.S
> +++ b/arch/arm64/lib/memcmp.S
> @@ -211,7 +211,7 @@ CPU_LE( lsr	tmp2, tmp2, tmp1 )
>  .Lunequal_proc:
>  	cbz	diff, .Lremain8
>  
> -/*There is differnence occured in the latest comparison.*/
> +/*There is differnence occurred in the latest comparison.*/

If you insist on doing this, please do it properly.

Will
