From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 28 Mar 2017 11:35:28 +0200
Subject: [PATCH v2 1/7] pinctrl: dt-bindings: Add documentation for Armada
 37xx pin controllers
In-Reply-To: <CACRpkdaP9Q=3ZeARTYizCKKtH6NdCrCnapxS7p=EdV1gvCZe8w@mail.gmail.com>
 (Linus Walleij's message of "Mon, 27 Mar 2017 11:18:48 +0200")
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
 <2dc869315a1b6bcc6d7eedd67b9ea8c0483b9789.1490120798.git-series.gregory.clement@free-electrons.com>
 <CACRpkdaP9Q=3ZeARTYizCKKtH6NdCrCnapxS7p=EdV1gvCZe8w@mail.gmail.com>
Message-ID: <87zig5agm7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On lun., mars 27 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Mar 21, 2017 at 7:28 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>
>> Document the device tree binding for the pin controllers found on the
>> Armada 37xx SoCs.
>>
>> Update the binding documention of the xtal clk which is a subnode of this
>> syscon node.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> These look all right to me, but let's see what the DT people say.
>
> This business with a subnode named "gpio-controller" that the code is
> checking for is not in the bindings or examples, is this part of the old
> Armada bindings?

It was updated in the version 3 I sent last week.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
