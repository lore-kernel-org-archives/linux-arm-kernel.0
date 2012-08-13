From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Aug 2012 16:11:32 +0200
Subject: [PATCH 6/6] ARM: dts: add pinctrl in PXA DT files
In-Reply-To: <5028CC25.5040707@gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
 <1343458722-17127-7-git-send-email-haojian.zhuang@gmail.com>
 <201208060844.29333.arnd@arndb.de>
 <CACRpkdayqp0ptdURHtYWC6G5pk1rNaAiWZkc7bdhv2osY1MaHA@mail.gmail.com>
 <5023C923.3080808@gmail.com>
 <CACRpkda0443PF-SwNaiJCO9RmdCFqw1+OtLgTBoTfZzwnFjJ4w@mail.gmail.com>
 <5028CC25.5040707@gmail.com>
Message-ID: <CACRpkdY+zLKYEqrt8+gBM5QAFDaOjuw0ka5CTcbH5b7HfE10dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 11:43 AM, Daniel Mack <zonque@gmail.com> wrote:
> On 10.08.2012 12:56, Linus Walleij wrote:

>> So the infrastructure I think already exists, but whereas all
>> current driver have their own config and mux (etc) parsing
>> code, pinconf-generic could provide something that would
>> be common for all driver using generic pin config.
>
> Exactly. And then the question is whether we want implicit behaviour.
> IOW - let dt_to_map_one_config() parse the generic bits and then call
> the driver specific augmentation code, if any.

Well if you make a patch I think we can see pretty clear
from the code what the best way of doing this will be.

Yours,
Linus Walleij
