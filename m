From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 02:53:45 -0700
Subject: [PATCH 06/19] ARM: ux500: Add nodes for the MSP into the HREF
 Device Tree
In-Reply-To: <1347016499-29354-7-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbs9_hLB9c7WbWeR_6+Le4Svzc9Y5wTNVebOiRDB-o33g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch enables the two important MSP devices for ST-Ericsson's
> hardware reference development board.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/hrefv60plus.dts |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
> index 62b2ac1..4f0aee8 100644
> --- a/arch/arm/boot/dts/hrefv60plus.dts
> +++ b/arch/arm/boot/dts/hrefv60plus.dts
> @@ -77,5 +77,13 @@
>
>                         status = "okay";
>                 };
> +
> +               msp1: msp at 80124000 {
> +                       status = "okay";
> +               };
> +
> +               msp3: msp at 80125000 {
> +                       status = "okay";
> +               };
>         };
>  };

Does this really "enable" the MSPs as the title claims?

Aren's there any kind of bindings needed, not even a
register base?

Yours,
Linus Walleij
