From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Jun 2016 10:16:09 +0100
Subject: [PATCH] arm64: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
In-Reply-To: <CACRpkdZcxYtZ84AkXsRGYPdPwBOzmK7srb5hzYFhVbEe0Mm2xg@mail.gmail.com>
References: <1464869670-7208-1-git-send-email-linus.walleij@linaro.org>
 <20160602180514.GD7697@arm.com>
 <CACRpkdZcxYtZ84AkXsRGYPdPwBOzmK7srb5hzYFhVbEe0Mm2xg@mail.gmail.com>
Message-ID: <20160603091608.GC9915@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 12:28:15AM +0200, Linus Walleij wrote:
> On Thu, Jun 2, 2016 at 8:05 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jun 02, 2016 at 02:14:30PM +0200, Linus Walleij wrote:
> >> This replaces:
> >>
> >> - "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB" as this can
> >>   now be selected directly.
> >>
> >> - "select ARCH_WANT_OPTIONAL_GPIOLIB" with no dependency: GPIOLIB
> >>   is now selectable by everyone, so we need not declare our
> >>   intent to select it.
> >>
> >> Cc: Michael B?sch <m@bues.ch>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >> ARM64/AArch64 maintainers:
> >> Please apply this patch directly for cleanups.
> >
> > Just checking -- you're aiming to have this in 4.7-rc ?
> 
> No cleanups for v4.8, not fixes for v4.7.
> There is no hurry, I have all patience in the world.

Okey doke! I thought this might be blocking some bigger work for the merge
window, but I'll leave it to Catalin given that's not the case.

Thanks for the clarification,

Will
