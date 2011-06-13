From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jun 2011 10:43:29 +0200
Subject: [PATCH 1/2] gpio: expose gpio_to_chip()
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3820B879F@AUSP01VMBX24.collaborationhost.net>
References: <1307695752-28051-1-git-send-email-linus.walleij@stericsson.com>
	<ADE657CA350FB648AAC2C43247A983F001F3820B879F@AUSP01VMBX24.collaborationhost.net>
Message-ID: <BANLkTinMPXQcS2tZAJE57d=J4XbpGp_aFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 5:57 PM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> On Friday, June 10, 2011 1:49 AM, Linus Walleij wrote:

>> This makes the gpio_to_chip() function available to drivers. The
>> usecase is when you want to add a few chip-specific operations
>> apart from the ones exposed in struct gpio_chip.
> (...)
>
> Linus,
>
> You'll need to fix a couple drivers for this to work. ?The symbol gpio_to_chip
> is a static symbol in a couple places other than gpiolib.c.

OK I fix! They are confusing anyway so should be patched pronto.

Linus Walleij
