From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 12 Oct 2017 15:50:29 +0200
Subject: [PATCH v3 3/4] dt-bindings: hwmon: Add
 ti-max-expected-current-milliamp property to ina2xx
In-Reply-To: <1507814282-1486-4-git-send-email-m.purski@samsung.com>
References: <1507814282-1486-1-git-send-email-m.purski@samsung.com>
 <CGME20171012131816eucas1p292bc0e20f141cfd21fe27c40700d82fb@eucas1p2.samsung.com>
 <1507814282-1486-4-git-send-email-m.purski@samsung.com>
Message-ID: <3fc7a4e9-825d-587a-71e4-145feb8c625e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2017 03:18 PM, Maciej Purski wrote:
> diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> index 02af0d9..9268595 100644
> --- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
> @@ -14,11 +14,13 @@ Optional properties:
>  
>  - shunt-resistor
>  	Shunt resistor value in micro-Ohm
> -
> +- ti-max-expected-current-milliamp

Normally after vendor name comma is used, so the property name 
should be "ti,max-expected-current-milliamp".
