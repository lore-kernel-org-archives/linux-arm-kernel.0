From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 07 Feb 2015 13:54:13 +0100
Subject: [PATCH v3 20/20] arm: mach-pxa: Decrement the power supply's
 device reference counter
In-Reply-To: <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
 (Krzysztof Kozlowski's message of "Fri, 30 Jan 2015 15:47:58 +0100")
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
Message-ID: <87iofd991m.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> Use power_supply_put() to decrement the power supply's device reference
> counter.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
