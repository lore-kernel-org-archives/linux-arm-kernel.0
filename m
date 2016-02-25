From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Feb 2016 15:49:13 +0100
Subject: [PATCH 01/14] pinctrl: sunxi: Add A83T R_PIO controller support
In-Reply-To: <20160225005644.GC4736@lukather>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-2-git-send-email-vishnupatekar0510@gmail.com>
 <CACRpkdbCgOBQw28d=qc1fAURY3x8UdoWqiMtXMZ=uWLaQj-nbg@mail.gmail.com>
 <20160211123648.GN31506@lukather>
 <CACRpkdaGZ4-S1A9zUUaBXXEazyJf_uZ4ESiBhw-CpozXMxfDHg@mail.gmail.com>
 <20160211151246.GO31506@lukather>
 <CACRpkdb7=x2bJP1nXpF2bP3U0t+NUHiuw_aeTAhbR8OXOrHn6A@mail.gmail.com>
 <20160225005644.GC4736@lukather>
Message-ID: <CACRpkdYQasUpLhJU16F3_GG7-wKt=wvb1Qqu2cJ62pCHLSii=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 1:56 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Hi Linus,
> On Tue, Feb 16, 2016 at 12:23:37AM +0100, Linus Walleij wrote:
>> On Thu, Feb 11, 2016 at 4:12 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Thu, Feb 11, 2016 at 02:47:57PM +0100, Linus Walleij wrote:
>>
>> >> Can you guys supply a MAINTAINERS entry for the sunxi
>> >> stuff?
>> >
>> > We have one, and Chen-Yu is listed as co-maintainer:
>> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n911
>>
>> Modified request:
>> can you put in F: wildcards there to match the files pertaining to
>> the sunxi platform, so that scripts/find-maintainer.pl finds them.
>
> I don't really know what you mean, on my laptop, if I run it, I get
> the following result:

OK the file is listed under SoC support, that works too.

Yours,
Linus Walleij
