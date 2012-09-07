From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Sep 2012 23:08:42 +0200
Subject: [PATCH 5/7] gpio: 74x164: Add support for the daisy-chaining
In-Reply-To: <2796775.6HPOQgPOKV@flexo>
References: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
 <1347020296-18796-6-git-send-email-maxime.ripard@free-electrons.com>
 <2796775.6HPOQgPOKV@flexo>
Message-ID: <CACRpkdboddXc5bay+1Nj-mx4mkXOvm7RoMbOdoKXcxqDUKbFdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 4:03 PM, Florian Fainelli <florian@openwrt.org> wrote:

>> +     if (!spi->dev.of_node) {
>> +             dev_err(&spi->dev, "No device tree data available.\n");
>> +             return -EINVAL;
>> +     }
>
> Should not this be folded in your previous patch?

True, but I've applied it, keep it here or split off as a separate
fix.

Yours,
Linus Walleij
