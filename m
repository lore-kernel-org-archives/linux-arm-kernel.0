From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jan 2014 14:36:15 +0100
Subject: [GIT PULL] get rid of <mach/timex.h>
In-Reply-To: <52CBE3DE.5010706@atmel.com>
References: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
 <87bo0clved.fsf@linaro.org> <20131219221758.GS14866@pengutronix.de>
 <20131220184715.GT14866@pengutronix.de>
 <52CBE3DE.5010706@atmel.com>
Message-ID: <CACRpkdboVtY2nBxGeWj_ReHJ5J8WuyuPHCwHM=yELBdePkX7Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 7, 2014 at 12:24 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 20/12/2013 19:47, Uwe Kleine-K?nig :

>> Please pull
>>
>>       git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh
>>
>> which points to 79f08d9ed217318b4f325b7fcf8f26dcd0e41689 now provided
>> you are happy with Linus W.'s series, too.
>
> Hi all,
>
> Is this pull-request is foreseen to be integrated in arm-soc for 3.14? I
> may have some material for Linus W. that I would like to queue that
> depend on these patches.

I'd like to know the status here. If the <timex.h> material is not
going into v3.14 I'd very much like my single patch to the serial
driver to go in, and the removal of AT91's <mach/gpio.h>.

In that case I'm requesting an ACK on the ARM portions from the
ARM SoC folks, so I can take it through the GPIO tree.

Yours,
Linus Walleij
