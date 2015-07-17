From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 17 Jul 2015 15:42:00 +0900
Subject: [PATCH v2 4/4] mfd: max77686: Split out regulator part from the
 DT binding
In-Reply-To: <1437114567-17629-5-git-send-email-javier@osg.samsung.com>
References: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
 <1437114567-17629-5-git-send-email-javier@osg.samsung.com>
Message-ID: <CAJKOXPe8rDLCt+Za+Qzkkd4JnFoyKtsFTmMbJL6+3Ark8qFYiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-07-17 15:29 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> The Maxim MAX77686 PMIC is a multi-function device with regulators,
> clocks and a RTC. The DT bindings for the clocks are in a separate
> file but the bindings for the regulators are inside the mfd part.
>
> To make it consistent with the clocks portion of the binding and
> because is more natural to look for regulator bindings under the
> bindings/regulator sub-directory, split the regulator portion of
> the DT binding and add it as a separate file.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
> Changes in v2:
> - Use a generic name for the max77686 node in the regulator example.
>
>  Documentation/devicetree/bindings/mfd/max77686.txt | 58 +-----------------
>  .../devicetree/bindings/regulator/max77686.txt     | 71 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt

Putting regulator bindings under regulator directory seems logical so
I am fine with it.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
