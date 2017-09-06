From: inguin@gmx.de (Ingo van Lil)
Date: Wed, 6 Sep 2017 12:25:01 +0200
Subject: [PATCH v3] clk: at91: utmi: set the mainck rate
In-Reply-To: <20170906095159.13295-1-ludovic.desroches@microchip.com>
References: <20170906095159.13295-1-ludovic.desroches@microchip.com>
Message-ID: <54f5a2d5-0dd3-e272-12e5-edc91fb2111e@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2017 11:51 AM, Ludovic Desroches wrote:

> By default, it is assumed that the UTMI clock is generated from a 12 MHz
> reference clock (MAINCK). If it's not the case, the FREQ field of the
> SFR_UTMICKTRIM has to be updated to generate the UTMI clock in the
> proper way.
> 
> The UTMI clock has a fixed rate of 480 MHz. In fact, there is no
> multiplier we can configure. The multiplier is managed internally,
> depending on the reference clock frequency, to achieve the target of
> 480 MHz.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Works fine with all my boards. Thanks!

Acked-by: Ingo van Lil <inguin@gmx.de>

Regards,
Ingo
