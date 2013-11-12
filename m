From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 18:06:49 +0100
Subject: [PATCH 4/5 v2] input: tc3589x-keypad: support probing from device
 tree
In-Reply-To: <20131112153057.GA9683@earth.universe>
References: <1384265618-10590-1-git-send-email-linus.walleij@linaro.org>
 <20131112153057.GA9683@earth.universe>
Message-ID: <CACRpkdb_bryGJo7CKGP5tj3RFGv=Gh+Q5m9ucVKqJ068tjPC2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 4:30 PM, Sebastian Reichel <sre@ring0.de> wrote:
> On Tue, Nov 12, 2013 at 03:13:38PM +0100, Linus Walleij wrote:

>> +     plat->no_autorepeat = of_property_read_bool(np, "linux,no-autorepeat");
>> +     plat->enable_wakeup = of_property_read_bool(np, "linux,wakeup");
>
> There is currently discussion going on for the property name of
> autorepeat:
>
> https://lkml.org/lkml/2013/11/11/680

So this binding is documented for GPIO keys in:
Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

This is probably the most used binding as GPIO matrixes are
not uncommon. But I don't know, yes it is a mess. (As usual.)

Yours,
Linus Walleij
