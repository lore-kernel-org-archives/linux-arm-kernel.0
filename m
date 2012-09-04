From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Sep 2012 09:19:10 +0200
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <20120903215505.GB31511@n2100.arm.linux.org.uk>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
 <201209011841.58977.arnd@arndb.de>
 <CACRpkdZhJyqeeXV_Zcfi7S01oH1Kw95qvAmOqrMKwhSLb-mX=Q@mail.gmail.com>
 <20120903215505.GB31511@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbXSaBNystUv9RTmDKrmV=OakFF49LPkoQtoi9FnaXmDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 3, 2012 at 11:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> [Me]
>> Currently I would make it impossible to use ATAGs if I do this since
>> the symbol does not exist, so I really need to base such an
>> approach in a tree which has CONFIG_ATAG in the first place.
>
> I've just merged that patch though.

OK great, Arnd do you have a Russell baseline in ARM SoC or is it
easier if I try to submit this series directly to Russell?

Yours,
Linus Walleij
