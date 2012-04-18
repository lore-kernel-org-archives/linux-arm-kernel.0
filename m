From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 14:23:12 +0200
Subject: [PATCH 1/2] ARM: dts: versatile-pb/ab fix MMC IRQs
In-Reply-To: <CACRpkdYu-kSW0SEkMWXiuuu+sy5h2qLSBCYn+vo-NpdohzaM6A@mail.gmail.com>
References: <1330682843-21163-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdYu-kSW0SEkMWXiuuu+sy5h2qLSBCYn+vo-NpdohzaM6A@mail.gmail.com>
Message-ID: <CACRpkdamvjCXUx3851dzyeC6h84ORtRj0C-xPND80M6S=Bd+zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 12:57 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Fri, Mar 2, 2012 at 11:07 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> The MMCI driver will not work without two IRQs since this is not
>> flagged as a single-irq variant. Looking through the complex IRQ
>> definition for the MMCI on the versatile (including an #if 1
>> statement forcing MMCI IRQ0 to the VIC) this appears to the the
>> correct IRQ number for both models.
>>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: Niklas Hernaeus <niklas.hernaeus@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Ping on this and 2/2, could go in as fixes as well.

Ping on these two, I'll happily put them in Russell's patch tracker if
not suitable for DT git.

Yours,
Linus Walleij
