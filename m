From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 21:11:40 +0100
Subject: [PATCH 4/5 v2] input: tc3589x-keypad: support probing from device
 tree
In-Reply-To: <20131112200514.GA15413@earth.universe>
References: <1384265618-10590-1-git-send-email-linus.walleij@linaro.org>
 <20131112153057.GA9683@earth.universe>
 <CACRpkdb_bryGJo7CKGP5tj3RFGv=Gh+Q5m9ucVKqJ068tjPC2g@mail.gmail.com>
 <20131112200514.GA15413@earth.universe>
Message-ID: <CACRpkdaAaLjm_b+OLj3tobxBN8YGUcTPnXJ=qtBqd02=FTxhjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 9:05 PM, Sebastian Reichel <sre@ring0.de> wrote:
> On Tue, Nov 12, 2013 at 06:06:49PM +0100, Linus Walleij wrote:

>> So this binding is documented for GPIO keys in:
>> Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
>>
>> This is probably the most used binding as GPIO matrixes are
>> not uncommon. But I don't know, yes it is a mess. (As usual.)
>
> I could find two boards using "gpio-matrix-keypad" in the mainline
> kernel and not a single instance of "linux,no-autorepeat":

In things connected to GPIO, I don't expect the in-kernel
device trees to be a good way so survey the usage of these
bindings. Anyone doing device trees on any system with a
few GPIOs can be using this.

But maybe we're lucky and won't break anyone's setup if
we change this?

Yours,
Linus Walleij
