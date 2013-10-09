From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 09 Oct 2013 14:06:46 -0700
Subject: [GIT PULL] Integrator device tree migration for v3.13
In-Reply-To: <CACRpkdY--WanMfoW_9hFV41LibvhBS+iK+tHSASqvNVWFrbb6Q@mail.gmail.com>
 (Linus Walleij's message of "Tue, 8 Oct 2013 09:11:32 +0200")
References: <CACRpkdY--WanMfoW_9hFV41LibvhBS+iK+tHSASqvNVWFrbb6Q@mail.gmail.com>
Message-ID: <87txgqrw61.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Hi ARM SoC folks,
>
> here is a first set of Integrator device tree migration patches,
> I'm still working to extend this series and move toward single
> zImage for the Integrator, but this would be good to get in as
> a base.
>
> Along with the fix for the timer that I sent yesterday this makes
> both Integrator/AP and Integrator/CP booth flawlessly from
> Device Tree.
>
> Necessary patches to U-Boot are also upstream and
> precompiled binaries can be found on my Integrator webpage:
> http://www.df.lth.se/~triad/krad/integrator/
>
> Please pull them in!

This looks pretty good to me, but I still like to pretend that there's a
world without DT. ;)  Stated otherwise, new/modified bindings should
have a Reviewed-by/Acked-by tag from the DT maintainers before we pull
them.

I see Mark Rutland has some comments on this series already, so we'll
ignore this and wait for another pull request when those issues are
sorted out.

Thanks,

Kevin
