From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Oct 2015 11:41:25 +0800
Subject: [PATCH 10/13] ARM: sun7i: dt: enable audio codec on Cubietruck
In-Reply-To: <1445460786-18280-11-git-send-email-maxime.ripard@free-electrons.com>
References: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
 <1445460786-18280-11-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v678LqQVMidbVqe0-JozJO_8fPTeZsW14hvL+UL4ikVzpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 4:53 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
>
> This commit enables the on-chip audio codec present on the A20 SoC
> and outlines the SoC to connector routes for the Cubietruck.

The latter bit is no longer true since you removed the routes.

ChenYu

>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index e6b019232a9e..8da939ab8350 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -101,6 +101,10 @@
>         status = "okay";
>  };
>
> +&codec {
> +       status = "okay";
> +};
> +
>  &cpu0 {
>         cpu-supply = <&reg_dcdc2>;
>  };
> --
> 2.6.2
>
