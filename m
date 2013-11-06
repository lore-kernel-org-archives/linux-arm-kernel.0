From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 12:55:51 +0100
Subject: [PATCH 06/13] ASoC: ux500_pcm: Extend ux500 MSP binding for
 enumeration
In-Reply-To: <20131106104658.GE11602@sirena.org.uk>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-7-git-send-email-lee.jones@linaro.org>
 <20131106104658.GE11602@sirena.org.uk>
Message-ID: <CACRpkdZgi9Egvm585Y9tJpmj0YX-oJBDg-C7pCu91Pf5ALMGLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 11:46 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Nov 06, 2013 at 10:16:18AM +0000, Lee Jones wrote:

>> + - id               : MSP ID - used during component registration
>
> I have no idea what this means or how one would pick the number?  It
> looks like something purely internal to the driver...

Actually it's quite common when we have several HW blocks of the
same thing to add something like an id. For example for different
GPIO banks.

But in this case I guess it may make more sense to flag one MSP
for RX and one for TX or something?

There are also two more such MSPs for streaming audio to the
Bluetooth audio portions.

Yours,
Linus Walleij
