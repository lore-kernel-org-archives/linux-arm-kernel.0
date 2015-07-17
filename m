From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 17 Jul 2015 15:36:06 +0900
Subject: [PATCH v2 3/4] mfd: Add DT binding for Maxim MAX77802 IC
In-Reply-To: <1437114567-17629-4-git-send-email-javier@osg.samsung.com>
References: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
 <1437114567-17629-4-git-send-email-javier@osg.samsung.com>
Message-ID: <CAJKOXPf9Vt=t+cNg5z6Y-VO7aNU+fc5_GuKsO8m1g4nFdv2Wiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-17 15:29 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> The MAX77802 is a chip that contains regulators, 2 32kHz clocks,
> a RTC and an I2C interface to program the individual components.
>
> The are already DT bindings for the regulators and clocks and
> these reference to a bindings/mfd/max77802.txt file, that didn't
> exist, for the details about the PMIC.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
> Changes in v2:
> - Use the correct "maxim,max77802" compatible string.
>   Suggested by Krzysztof Kozlowski
> - Use a pmic generic node name for the max77802 node example.
>   Suggested by Sergei Shtylyov.
>
>  Documentation/devicetree/bindings/mfd/max77802.txt | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
