From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Sep 2016 12:10:48 +0200
Subject: [PATCH] pinctrl: mvebu: orion5x: Generalise mv88f5181l support
 for 88f5181
In-Reply-To: <CACRpkdbo6JmR=K58KQ_J0Gd5_gLqub65watU-iEabQ0rWdeVpQ@mail.gmail.com>
 (Linus Walleij's message of "Tue, 20 Sep 2016 23:54:48 +0200")
References: <20160920162635.4195-1-gregory.clement@free-electrons.com>
 <CACRpkdbo6JmR=K58KQ_J0Gd5_gLqub65watU-iEabQ0rWdeVpQ@mail.gmail.com>
Message-ID: <87a8f15zrr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On mar., sept. 20 2016, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Sep 20, 2016 at 6:26 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>
>> From: Jamie Lentin <jm@lentin.co.uk>
>>
>> As far as I'm aware the mv88f5181-b1 and mv88f5181l are the same at the
>> pinctrl level, so re-use the definitions for both.
>>
>> [gregory.clement at free-electrons.com: fix commit title]
>> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> Is this the patch from your pull request?

yes this one.

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Or do you prefer that I take it into the pinctrl tree?

No it is ok, it will be in the second tentaive of my pull request.

Thanks,

Gregory


>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
