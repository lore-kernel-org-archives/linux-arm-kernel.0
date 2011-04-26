From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Apr 2011 09:48:02 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <4DB5C307.1060507@codeaurora.org>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<4DB5C307.1060507@codeaurora.org>
Message-ID: <BANLkTikvzghJ3Ey82mWiMU3T28VC8WuAtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/25 Rohit Vaswani <rvaswani@codeaurora.org>:

> Another API to select this would make it more powerful. At boot a lot of
> gpios are configured by the board-file.

Yeah I have already revised this patchset...

> How do you feel about another API that can accepts the gpio config
> parameters (void *data) and set them all at once?
> This would make it more generic to suit different gpio parameters that an
> arch might have.

It's done that way now, and as Alan noted it fits hand-in-glove with
devicetree initialization that way too.

Yours,
Linus Walleij
