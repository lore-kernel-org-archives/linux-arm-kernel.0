From: rth@twiddle.net (Richard Henderson)
Date: Fri, 8 Jan 2016 07:42:49 -0800
Subject: [PATCH v2 2/6] alpha/extable: use generic search and sort routines
In-Reply-To: <1452007180-27411-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1452007180-27411-1-git-send-email-ard.biesheuvel@linaro.org>
 <1452007180-27411-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <568FD8F9.4050602@twiddle.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2016 07:19 AM, Ard Biesheuvel wrote:
> Replace the arch specific versions of search_extable() and sort_extable()
> with calls to the generic ones, which now support relative exception
> tables as well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/alpha/include/asm/uaccess.h | 10 ++-
>  arch/alpha/mm/Makefile           |  2 +-
>  arch/alpha/mm/extable.c          | 92 --------------------
>  3 files changed, 9 insertions(+), 95 deletions(-)

Acked-by: Richard Henderson <rth@twiddle.net>


r~
