From: dhdang@apm.com (Duc Dang)
Date: Tue, 29 Mar 2016 12:11:21 -0700
Subject: [PATCH] arm64: dts: apm: Fix compatible string for X-Gene 2 SATA
 controller DTS node
In-Reply-To: <1459245294-22678-1-git-send-email-rsahu@apm.com>
References: <1459245294-22678-1-git-send-email-rsahu@apm.com>
Message-ID: <CADaLNDnU7UJOOFs9euPP035iJX5b1-p7jLoKB5f0Sn==Ec3sYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 2:54 AM, Rameshwar Prasad Sahu <rsahu@apm.com> wrote:
> Fix X-Gene SATA controller compatible string for Merlin board.
>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> Acked-by: Suman Tripathi <stripathi@apm.com>

I will queue this patch into xgene-next tree.

> ---
>  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> index 5d87a3d..74d971e 100644
> --- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> @@ -524,7 +524,7 @@
>                 };
>
>                 sata1: sata at 1a000000 {
> -                       compatible = "apm,xgene-ahci";
> +                       compatible = "apm,xgene-ahci-v2";
>                         reg = <0x0 0x1a000000 0x0 0x1000>,
>                               <0x0 0x1f200000 0x0 0x1000>,
>                               <0x0 0x1f20d000 0x0 0x1000>,
> @@ -534,7 +534,7 @@
>                 };
>
>                 sata2: sata at 1a200000 {
> -                       compatible = "apm,xgene-ahci";
> +                       compatible = "apm,xgene-ahci-v2";
>                         reg = <0x0 0x1a200000 0x0 0x1000>,
>                               <0x0 0x1f210000 0x0 0x1000>,
>                               <0x0 0x1f21d000 0x0 0x1000>,
> @@ -544,7 +544,7 @@
>                 };
>
>                 sata3: sata at 1a400000 {
> -                       compatible = "apm,xgene-ahci";
> +                       compatible = "apm,xgene-ahci-v2";
>                         reg = <0x0 0x1a400000 0x0 0x1000>,
>                               <0x0 0x1f220000 0x0 0x1000>,
>                               <0x0 0x1f22d000 0x0 0x1000>,
> --
> 1.7.1
>

Regards,
Duc Dang.
