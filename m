From: robherring2@gmail.com (Rob Herring)
Date: Wed, 28 Aug 2013 10:21:23 -0500
Subject: [PATCH 08/19] highbank: enable big-endian
In-Reply-To: <1377639509-22778-9-git-send-email-ben.dooks@codethink.co.uk>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-9-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAL_Jsq+htCWwNjq31RcO2YR4cjM+p3cr8r6Nedk-kngFJkQ5=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 4:38 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Apart from a xgmac driver issue, the highbank seems to work correctly in
> big-endian mode. Allow the selection of big-endian in the system.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/mach-highbank/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
> index cd9fcb1..4f57554 100644
> --- a/arch/arm/mach-highbank/Kconfig
> +++ b/arch/arm/mach-highbank/Kconfig
> @@ -18,3 +18,4 @@ config ARCH_HIGHBANK
>         select PL320_MBOX
>         select SPARSE_IRQ
>         select USE_OF
> +       select ARCH_SUPPORTS_BIG_ENDIAN

The select entries should be sorted.

Rob
