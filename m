From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 9 Jun 2015 09:42:30 +0100
Subject: [PATCH] ARM: pgtable: Fix typo in the comment
In-Reply-To: <024f01d0a280$e561f460$b025dd20$@lge.com>
References: <024f01d0a280$e561f460$b025dd20$@lge.com>
Message-ID: <CAPvkgC1rWZNTHu6sVkPtOpbQaQ7EdvCUCUZu7twmn2wx=O6WOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 June 2015 at 07:52, Hyuk Myeong <hyuk.myeong@lge.com> wrote:
> This patch fix a spelling typo in the comment in pgtable-2level.h.
>

Hi Hyuk,

> Signed-off-by: Hyuk Myeong <hyuk.myeong@lge.com>
> ---
>  arch/arm/include/asm/pgtable-2level.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/pgtable-2level.h
> b/arch/arm/include/asm/pgtable-2level.h
> index bfd662e..49f91be 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -66,7 +66,7 @@
>   *
>   * However, when the "young" bit is cleared, we deny access to the page
>   * by clearing the hardware PTE.  Currently Linux does not flush the TLB
> - * for us in this case, which means the TLB will retain the transation
> + * for us in this case, which means the TLB will retain the transaction

Don't you mean "translation" rather than "transaction"?

Cheers,
--
Steve

>   * until either the TLB entry is evicted under pressure, or a context
>   * switch which changes the user space mapping occurs.
>   */
> --
> 1.9.3
>
