From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 22 Apr 2014 15:27:16 +0200
Subject: [PATCH v3 5/7] pinctrl: sunxi: define A31 R_PIO pin functions
In-Reply-To: <CACRpkdam1a0TUPx4rMG6mzXwRdYZgfeZdBUhk0hnWAbKVQKr=A@mail.gmail.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>	<1397137966-30818-6-git-send-email-boris.brezillon@free-electrons.com>
 <CACRpkdam1a0TUPx4rMG6mzXwRdYZgfeZdBUhk0hnWAbKVQKr=A@mail.gmail.com>
Message-ID: <53566E34.2070709@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 22/04/2014 13:47, Linus Walleij wrote:
> On Thu, Apr 10, 2014 at 3:52 PM, Boris BREZILLON
> <boris.brezillon@free-electrons.com> wrote:
>
>> The A31 SoC provides both PL and PM pio bank through the R_PIO block.
>>
>> These pins all support gpio function and can bbe assigned to system
>> peripherals (like TWI, P2WI, JTAG, ...)
>>
>> Add new compatible string to the DT bindings doc.
>>
>> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> PARTLY APPLIED.
>
> The patch to the DT bindings apparently depend on some
> patch that I do *NOT* have in my tree, please figure out what is
> going on here and help me figure out what and how to apply the
> changes to the bindings.

Oops: I dropped the patch documenting existing compatible strings in
this version ([1]).

>
> The hunk adding the docs was dropped from the patch, please
> develop new series on top of my pinctrl devel branch as I
> push it out.

Sure, I'll make a new patch listing all compatible strings (including
this new one) in the sunxi pinctrl DT bindings doc.

Thanks,

Boris

[1] https://lkml.org/lkml/2014/4/9/258
>
> Yours,
> Linus Walleij

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
