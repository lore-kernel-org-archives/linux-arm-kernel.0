From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 14 Jun 2015 13:31:28 +0900
Subject: [PATCH v2] ARM: dts: exynos4210-trats: add max8997 IRQ
In-Reply-To: <1395828429-11023-1-git-send-email-r.baldyga@samsung.com>
References: <1395828429-11023-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <CAJKOXPdFob6KB_bLCUMLeKT+eUc3BDATA0XRR00STia5rv1=jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-03-26 19:07 GMT+09:00 Robert Baldyga <r.baldyga@samsung.com>:
> This patch adds IRQ line specification for the MAX8997 chip and necessary
> pinctrl group to configure pull-up and driver strength of the pin.
> It's needed for proper handling of IRQs coming from MAX8997 multifunction
> device (IRQs are used by PMIC, MUIC and RTC).
>
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

(limit the CC list)
Yet another old patch I found on LKML... Robert, is this patch still
worth applying? If yes, would you be so kind to rebase it and resend?

Best regards,
Krzysztof
