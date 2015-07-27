From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jul 2015 11:43:52 +0200
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
Message-ID: <CACRpkdZOeMqT0cZWYPOrtKGL2FdAy4=19JZMmF8KuU7pYZYuMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 9:46 AM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> On Tue, Jul 14, 2015 at 07:57:49AM +0200, Sascha Hauer wrote:
>>
>> Note that in the recently introduced Mediatek pinctrl driver we used
>> 'pinmux' for the property that you name 'pins' here. We probably want to
>> use the same name.
>
> This driver fits most of my needs but I didn't do it in this way for the
> two previous reasons. If it is not an issue to add a new
> dt_node_to_map() implementation which should be quite close to the
> mediatek one, let's do it.

OK if you can do that so we have some order and obtain Sascha's
ACK I'm in for the patch.

Maybe there is something like that further up in my mailbox, need
to browse :)

Yours,
Linus Walleij
