From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Feb 2016 14:47:57 +0100
Subject: [PATCH 01/14] pinctrl: sunxi: Add A83T R_PIO controller support
In-Reply-To: <20160211123648.GN31506@lukather>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-2-git-send-email-vishnupatekar0510@gmail.com>
 <CACRpkdbCgOBQw28d=qc1fAURY3x8UdoWqiMtXMZ=uWLaQj-nbg@mail.gmail.com>
 <20160211123648.GN31506@lukather>
Message-ID: <CACRpkdaGZ4-S1A9zUUaBXXEazyJf_uZ4ESiBhw-CpozXMxfDHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 1:36 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Feb 11, 2016 at 12:59:47PM +0100, Linus Walleij wrote:
>> On Sun, Jan 31, 2016 at 2:20 AM, Vishnu Patekar
>> <vishnupatekar0510@gmail.com> wrote:
>>
>> > The A83T has R_PIO pin controller, it's same as A23, execpt A83T
>> > interrupt bit is 6th and A83T has one extra pin PL12.
>> >
>> > Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
>>
>> Maxime, can you look at this patch?
>
> Chen-Yu had one minor comment on it,

OK waiting for a new version.

> and he's also the Allwinner
> maintainer now, so you can trust his Acked-by just like you would
> trust mine ;)

Can you guys supply a MAINTAINERS entry for the sunxi
stuff?

Yours,
Linus Walleij
