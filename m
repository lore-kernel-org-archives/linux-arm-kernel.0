From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 01 Sep 2013 00:17:03 +0400
Subject: [PATCH 08/20] highbank: enable big-endian
In-Reply-To: <1377889856-9447-9-git-send-email-ben.dooks@codethink.co.uk>
References: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377889856-9447-9-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <52224F3F.2010804@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/30/2013 11:10 PM, Ben Dooks wrote:

> Apart from a xgmac driver issue, the highbank seems to work correctly in
> big-endian mode. Allow the selection of big-endian in the system.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   arch/arm/mach-highbank/Kconfig |    2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
> index cd9fcb1..f82bd88 100644
> --- a/arch/arm/mach-highbank/Kconfig
> +++ b/arch/arm/mach-highbank/Kconfig
[...]
> @@ -18,3 +19,4 @@ config ARCH_HIGHBANK
>   	select PL320_MBOX
>   	select SPARSE_IRQ
>   	select USE_OF
> +

    I don't think you really intended to add this line at end of file.

WBR, Sergei
