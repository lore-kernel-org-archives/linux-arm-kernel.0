From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 17:51:26 +0200
Subject: [PATCH] pinctrl: establish pull-up/pull-down terminology
In-Reply-To: <20926.42315.907448.451620@ipc1.ka-ro>
References: <1371379548-6482-1-git-send-email-linus.walleij@stericsson.com>
 <20926.42315.907448.451620@ipc1.ka-ro>
Message-ID: <CACRpkdZXd=yOrS5KPW-Rx4SQM_9p7Hwyn4LrrCJtavKG2-vjjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 7:57 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Linus Walleij writes:

>> - *   if it is 0, pull-up is disabled.
>> + *   if it is 0, pull-up it total, i.e. the pin is connected to VDD.
>                             ^^
> 'is'?

Thanks for noticing, fixed this up when applying.

Yours,
Linus Walleij
