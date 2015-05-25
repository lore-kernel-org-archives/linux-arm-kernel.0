From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 25 May 2015 14:27:22 +0200
Subject: [PATCH] ARM: dts: odroidxu3: Enable wake alarm of S2MPS11 RTC
In-Reply-To: <1432554253-25886-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1432554253-25886-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <5563152A.4020104@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/25/2015 01:44 PM, Krzysztof Kozlowski wrote:
> The IRQB of S2MPS11 PMIC is wired to XEINT4 (GPX0-4) through pull-up
> resistor.
> 
> Add interrupt properties and pinctrl configuration to enable RTC wake
> alarm of rtc-s5m driver. This also removes a warning:
> sec_pmic 4-0066: No interrupt specified, no interrupts
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---

I haven't checked with the board schematics but the patch
looks good to me.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
