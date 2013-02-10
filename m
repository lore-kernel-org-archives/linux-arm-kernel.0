From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 10 Feb 2013 16:08:15 +0100
Subject: [GIT PULL] ux500 DT related fixes and platform enhancements
In-Reply-To: <20130208083121.GG7519@gmail.com>
References: <20130131115552.GG5301@gmail.com> <20130206135911.GB7519@gmail.com>
 <CAOesGMiJTcjdEJzSDkpdV-ZCqN24uVmfjM-HOt+ojErS=98TmQ@mail.gmail.com>
 <CAF2Aj3gaFtPs7gLd3snzVr1a8Px5A_RN1vz=M+U_LZ3MBpyqqw@mail.gmail.com>
 <CACRpkdaTajxS6YbjyyGPQ=qWiAkLaPySU6WncQ2E8HoAtGXqjA@mail.gmail.com>
 <20130208083121.GG7519@gmail.com>
Message-ID: <CACRpkdYChVn6RMnbckR0UiPZC+WdqZjWKvMyoPf=oJifCEgAgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 8, 2013 at 9:31 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 07 Feb 2013, Linus Walleij wrote:
>>
>> OK so what about I pull this branch into my ux500 git and
>> call it a devicetree branch, and then we can optionally
>> merge a few of those ARM: ux500: * patches that
>> was sent for the regulator stuff on top of that as well?
>
> There are two reasons why I don't like that idea: 1) As Olof pointed
> out, a lot of these patches aren't actually DT related, and 2) I
> really want all of the regulator stuff to stay together. Each of the
> changes in the platform code are directly dependent on the ones
> happening in the regulator driver, and visa versa. It would be best if
> they continued to be taken though Marks tree.

I understand this and I'm fully aligned for the non-DT parts.

But I'm worrying about a plethora or merge conflicts
under arch/arm/boot/dts/*

I already pulled some of the pinctrl device tree patches over to
my Linux-stericsson tree to avoid clashes between ARM SoC
and pinctrl.

Rationale: I don't want arch/arm/boot/dts to become the new
boardfile-type merge-clash point. That will just invoke the
wrath of the Big Penguin.

Yours,
Linus Walleij
