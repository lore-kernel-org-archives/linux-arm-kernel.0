From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 20 Jul 2013 12:32:15 +0530
Subject: [PATCH 20/22] ARM: ux500: Remove '0x's from Spear 300 DTS file
In-Reply-To: <1374242333-6852-20-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
 <1374242333-6852-20-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOh2x==EBzy6MMy0Jv1=VSAD7Kdw7=Jag8g4oz-kfRH0XafGaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 7:28 PM, Lee Jones <lee.jones@linaro.org> wrote:
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/spear300.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
> index f79b3df..8970a4a 100644
> --- a/arch/arm/boot/dts/spear300.dtsi
> +++ b/arch/arm/boot/dts/spear300.dtsi
> @@ -52,7 +52,7 @@
>                         status = "disabled";
>                 };
>
> -               shirq: interrupt-controller at 0x50000000 {
> +               shirq: interrupt-controller at 50000000 {
>                         compatible = "st,spear300-shirq";
>                         reg = <0x50000000 0x1000>;
>                         interrupts = <28>;

Should Ux500 come in subject line? And please write Spear as
SPEAr.

Otherwise all three patches look fine.

Ackedy-by: Viresh Kumar <viresh.kumar@linaro.org>
