From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 21:26:40 +0200
Subject: [PATCH 1/3] ARM: mediatek: Add basic support for mt6592
In-Reply-To: <1412760987-1668-1-git-send-email-ibanezchen@gmail.com>
References: <1412760987-1668-1-git-send-email-ibanezchen@gmail.com>
Message-ID: <3025258.E07Q6Wnu6t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 October 2014 17:36:25 Howard Chen wrote:
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x0>;
> +               };
> +               cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x1>;
> +               };
> +               cpu at 2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x2>;
> +               };
> +               cpu at 3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0x3>;
> +               };
> +
> +       };
> 

Shouldn't there be eight cpu nodes for mt6592?

	Arnd
