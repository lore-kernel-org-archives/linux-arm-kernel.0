From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 17 Aug 2015 16:29:18 +0900
Subject: [PATCH 6/6] gpiolib: Add gpio name information to
 /sys/kernel/debug/gpio
In-Reply-To: <CACRpkdajd5B6qUa6mi_0m53eMtLenoAWUCnmq-mOC+EhXfzpTA@mail.gmail.com>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
 <1438680203-13432-7-git-send-email-mpa@pengutronix.de>
 <CACRpkdajd5B6qUa6mi_0m53eMtLenoAWUCnmq-mOC+EhXfzpTA@mail.gmail.com>
Message-ID: <CAAVeFuKSQP2DYWdhYy-k+cr9F0jc46Q-xuoWXSTguQYaf3SY+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 7:02 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Aug 4, 2015 at 11:23 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>
>> Add some information about gpio names to the debugfs gpio file. name and
>> label of a GPIO are then displayed next to each other. This way it is
>> easy to see what the real name of GPIO is and what the driver requested
>> it for.
>>
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>
> This patch looks correct in the context.

Looks correct indeed, but on a related note one might question the
need to have both a "name" and a "label" for a GPIO?
