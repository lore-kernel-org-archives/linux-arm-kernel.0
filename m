From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 9 Sep 2013 15:10:27 -0700
Subject: Inte IOP Xscale updates
In-Reply-To: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
References: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
Message-ID: <CAA9_cmcMLooT6=+PwR9rx4ALmNeKG=qXWn+K_dLJ+CVj9u6tYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 3, 2013 at 5:01 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Hi XScale folks,
>
> I haven't really seen any functional patches or confirmation that the
> XScale machines in arch/arm/iop* are even booting since 2010 or
> so.
>
> Can you confirm that you boot-test these machines regularly?
>

I lost access to my boards when I left, but now that I am back I am
trying to track them down.  iop32x may be the only boards that matter
here, I never saw an iop13xx outside of the development board.

> I am worried that we maintain code that is not used or even working
> see.
>
> What are your thought about multiplatform and device tree? I am
> pretty certain that if the iop machines were converted to device tree
> we could collapse these machines into one directory with few files,
> but I may be wrong.
>

I have not been following device-tree conversions for how they handle
legacy boot loaders?

...I'll just start with reviewing your gpio conversion.

--
Dan
