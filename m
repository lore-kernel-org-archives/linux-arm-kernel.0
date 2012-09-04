From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Sep 2012 10:36:01 +0100
Subject: [PATCH] ARM: ux500: Provide SMSC911x fixed-regulator when not
 booting DT
In-Reply-To: <CACRpkdb9X1ay6A1jJk==73azz0bbto0V4pBO=vOfC30_ygwZLg@mail.gmail.com>
References: <1345809612-30992-1-git-send-email-lee.jones@linaro.org>
 <20120903133333.GE31163@gmail.com>
 <CACRpkdb_aW-uxf_4GQpRWJhLqD_QujH1BOFeG4MgVHfRasGY+A@mail.gmail.com>
 <20120904090846.GA6091@gmail.com>
 <CACRpkdb9X1ay6A1jJk==73azz0bbto0V4pBO=vOfC30_ygwZLg@mail.gmail.com>
Message-ID: <20120904093555.GB6091@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 11:29:02AM +0200, Linus Walleij wrote:
> On Tue, Sep 4, 2012 at 11:08 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, Sep 04, 2012 at 10:53:32AM +0200, Linus Walleij wrote:
> >
> >> You forgot to add select REGULATOR_FIXED_VOLTAGE to
> >> the MOP500 Kconfig entry, but I added it when applying.
> >
> > I didn't forget. I intentionally left it out because it's
> > unconditionally set in the defconfig.
> 
> Since disabling that from the config breaks compile this means
> that you just broke Arnds randconfig builds :-P
> 
> If something *must* be configured for the thing to compile,
> so it with select.

Ah, I see.

Noted, thanks.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
