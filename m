From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2012 19:34:59 +0200
Subject: [PATCH v2] pinctrl: implement pinctrl deferred probing
In-Reply-To: <20120412170924.GA18049@opensource.wolfsonmicro.com>
References: <1334133248-1452-1-git-send-email-linus.walleij@stericsson.com>
 <20120412170924.GA18049@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdb8suiq=eu26JB==AscfdgJB7QKyxTn_1m=6Bngp8P5Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 7:09 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks!

> Note that the probe deferral code already has info level logs every time
> it does anything so you'll probably have a hint from that when it kicks
> into action.

Yeah, but these messages tell you what caused the deferral.
I'll take some patches the day someone thinks the kernel is
getting too talkative...

Yours,
Linus Walleij
