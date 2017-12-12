From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Dec 2017 11:52:28 +0100
Subject: [RFC PATCH 1/3] dt-bindings: pinctrl: sunxi: document new generic
 binding
In-Reply-To: <be52417d-9509-f638-65b6-f455fade0c39@arm.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <20171113012523.2328-2-andre.przywara@arm.com>
 <CACRpkdbpfkM4odz425+4qyUCF5vqPWBQ=F5Yk7AtJL5SqXghpg@mail.gmail.com>
 <20171124105240.GB3792@ulmo> <20efcf8f-85a5-3cad-a84b-434ee5cad68e@arm.com>
 <20171124133123.GA15999@ulmo> <0c8051e6-5d8c-32d6-97e4-11c2283da5b4@arm.com>
 <CACRpkdZ70a7Vk1QPFhkms6ucWmSH6rOUD9_J0h=NjhK+vfXNAA@mail.gmail.com>
 <be52417d-9509-f638-65b6-f455fade0c39@arm.com>
Message-ID: <CACRpkdZBMeG0d2W9n5UQ6c-XgQcoGYJG4bAwnMqq_awpQCuQ7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 1:55 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
> On 01/12/17 09:56, Linus Walleij wrote:

>> It is a valid cause. Just
>> has to be weighed with other stuff, like maintainability, debuggability,
>> maintainers viewpoint. ...
>
> So to keep Maxime happy I actually designed this "driver" more like a
> shim: to generate the table the current driver expects from the DT, and
> actually not touching the existing driver at all.
> So maintainability should actually be less of a concern: the driver will
> just work with whatever one throws at it from the DT side, without
> requiring frequent changes or additions.
> In the moment we still need to write, review and merge *data* files for
> each new SoC. And as I mentioned before, Allwinner decided to push for
> new, slightly different chips every few months, so there will be more to
> come. With at least the pinctrl driver out of the way we have one
> problem less to worry about.

I think you need mainly to convince Maxime that this is something that
he wants to maintain, going forward.

I am as subsystem maintainer pretty pleased as long as standard
properties etc are used to encode the data into the devicetree, and
DT maintrainers are not actively vetoing what you do.

If it leads to a conflict between Allwinner maintainers it is not worth the
effort for reasons that are social rather than technical. To me it is a very
nice but as with all volunteer communities also very vulnerable
endavour.

Please make sure not to push your point so hard that it hurts your
our your colleagues feelings.

I know people are passionate about their ideas, which is usally good
but also scare me sometimes because they sometimes become so
passionate that it makes them bad team players.

Yours,
Linus Walleij
