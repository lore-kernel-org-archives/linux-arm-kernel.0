From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Apr 2015 16:40:04 +0200
Subject: [PATCH 04/12] trivial: ARM: lib/lib1funcs.S: fix typo
 s/substractions/subtractions/
In-Reply-To: <1430219491-5076-5-git-send-email-ao2@ao2.it>
References: <1430219491-5076-1-git-send-email-ao2@ao2.it>
 <1430219491-5076-5-git-send-email-ao2@ao2.it>
Message-ID: <CAKv+Gu-7SRFaPbXQynfu6OiZCnS5xA2qMkRYWmgf0+T9SWdDRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2015 at 13:11, Antonio Ospite <ao2@ao2.it> wrote:
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/lib/lib1funcs.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
> index 947567f..af2267f 100644
> --- a/arch/arm/lib/lib1funcs.S
> +++ b/arch/arm/lib/lib1funcs.S
> @@ -167,7 +167,7 @@ Boston, MA 02111-1307, USA.  */
>
>  #endif
>
> -       @ Perform all needed substractions to keep only the reminder.
> +       @ Perform all needed subtractions to keep only the reminder.

While you're at it, you should perhaps correct the other typo in this
line as well?
(remAinder)

>         @ Do comparisons in batch of 4 first.
>         subs    \order, \order, #3              @ yes, 3 is intended here
>         blt     2f
> @@ -189,7 +189,7 @@ Boston, MA 02111-1307, USA.  */
>         teqne   \dividend, #0
>         beq     5f
>
> -       @ Either 1, 2 or 3 comparison/substractions are left.
> +       @ Either 1, 2 or 3 comparison/subtractions are left.

Same here -> comparisonS (plural)

>  2:     cmn     \order, #2
>         blt     4f
>         beq     3f
> --
> 2.1.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
