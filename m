From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 15 Jul 2015 10:29:18 +0200
Subject: [RESEND PATCH 1/2] pinctrl: change function behavior for per pin
 muxing controllers
In-Reply-To: <20150715074642.GA14886@odux.rfo.atmel.com>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-2-git-send-email-ludovic.desroches@atmel.com>
 <557EF60D.8020007@wwwdotorg.org>
 <20150617123816.GB12295@odux.rfo.atmel.com>
 <5581988C.50000@wwwdotorg.org>
 <20150618123348.GB20227@odux.rfo.atmel.com>
 <20150714055749.GB5161@pengutronix.de>
 <20150715074642.GA14886@odux.rfo.atmel.com>
Message-ID: <20150715082918.GB14886@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 09:46:42AM +0200, Ludovic Desroches wrote:
> This driver fits most of my needs but I didn't do it in this way for the
> two previous reasons. If it is not an issue to add a new
> dt_node_to_map() implementation which should be quite close to the
> mediatek one, let's do it.

Thinking more about it, there is something I have missed that can change
many things is that one pin is one group in Mediatek driver.

If I add the pin mux value in my macros with the pin number and the
ioset, group_defs node is still useful to declare group of pins.

Ludovic
