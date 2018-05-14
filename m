From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 14 May 2018 15:30:09 +0200
Subject: [PATCH] ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier
In-Reply-To: <1526253724-3596-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1526253724-3596-1-git-send-email-hernan@vanguardiasur.com.ar>
Message-ID: <20180514133009.GY10960@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/05/2018 20:22:04-0300, Hern?n Gonzalez wrote:
> GPIO_ACTIVE_LOW was being used to specify an interrupt, use
> IRQ_TYPE_EDGE_RISING instead. This improves DT readability.
> 
> Signed-off-by: Hern?n Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
