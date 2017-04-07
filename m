From: joel@jms.id.au (Joel Stanley)
Date: Fri, 7 Apr 2017 11:40:25 +0930
Subject: [PATCH] ARM: dts: aspeed: add a fastread property
In-Reply-To: <1491498153-26564-1-git-send-email-clg@kaod.org>
References: <1491498153-26564-1-git-send-email-clg@kaod.org>
Message-ID: <CACPK8XedrYaeBq5P5g0XUzXS6WHzPLwXAMF5V7cp9ntuxC=0hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 7, 2017 at 2:32 AM, C?dric Le Goater <clg@kaod.org> wrote:
> All chips on OpenPOWER platforms support the fastread SPI command.
>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Thanks, applied.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-ast2500-evb.dts      | 2 ++
>  arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 2 ++
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  | 2 ++
>  3 files changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> index 8f82e8ab1875..7c90dac99822 100644
> --- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> @@ -24,6 +24,7 @@
>         status = "okay";
>         flash at 0 {
>                 status = "okay";
> +               m25p,fast-read;
>                 label = "bmc";
>         };
>  };
> @@ -32,6 +33,7 @@
>         status = "okay";
>         flash at 0 {
>                 status = "okay";
> +               m25p,fast-read;
>                 label = "pnor";
>         };
>  };
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> index aab1889f702f..112551766275 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> @@ -35,6 +35,7 @@
>         status = "okay";
>         flash at 0 {
>                 status = "okay";
> +               m25p,fast-read;
>                 label = "bmc";
>         };
>  };
> @@ -43,6 +44,7 @@
>         status = "okay";
>         flash at 0 {
>                 status = "okay";
> +               m25p,fast-read;
>                 label = "pnor";
>         };
>  };
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> index e3c6358bc7d9..b82f67eb3dae 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> @@ -35,6 +35,7 @@
>         status = "okay";
>         flash at 0 {
>                 status = "okay";
> +               m25p,fast-read;
>                 label = "bmc";
>         };
>  };
> @@ -43,6 +44,7 @@
>         status = "okay";
>         flash at 0 {
>                 status = "okay";
> +               m25p,fast-read;
>                 label = "pnor";
>         };
>  };
> --
> 2.7.4
>
