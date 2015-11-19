From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 19 Nov 2015 20:58:58 +0100
Subject: [PATCH 2/2] ARM: use const and __initconst for smp_operations
In-Reply-To: <1447551593-22246-3-git-send-email-yamada.masahiro@socionext.com>
References: <1447551593-22246-1-git-send-email-yamada.masahiro@socionext.com>
 <1447551593-22246-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <564E2A02.90903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.11.2015 02:39, Masahiro Yamada wrote:
> These smp_operations structures are not over-written, so add "const"
> qualifier and replace __initdata with __initconst.
> 
> Also, add "static" where it is possible.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

> ---
[...]
>  arch/arm/mach-berlin/platsmp.c       | 2 +-
[...]
>  54 files changed, 64 insertions(+), 64 deletions(-)

For berlin,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
