From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Nov 2012 13:18:06 +0000
Subject: [PATCH 2/6] pinctrl: Update clock handling for the
 pinctrl-nomadik GPIO driver
In-Reply-To: <CACRpkdbkcgE-qwuGgOvK9jGTj-0qy3eTFLsN3LYe1G17LmHk9g@mail.gmail.com>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
 <1351089926-32161-3-git-send-email-lee.jones@linaro.org>
 <CACRpkda2NQok7kzh0pFmZPYd4nky1kUw=67DZAYAJAXGuc1yzQ@mail.gmail.com>
 <CACRpkdbNWE6hOdVFPxHv7MVHkZUBW3LC035CxJkZVmr8j05Kqw@mail.gmail.com>
 <20121025155143.GK4008@gmail.com>
 <CACRpkdbkcgE-qwuGgOvK9jGTj-0qy3eTFLsN3LYe1G17LmHk9g@mail.gmail.com>
Message-ID: <20121114131806.GA17338@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2012, Linus Walleij wrote:

> On Thu, Oct 25, 2012 at 5:51 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 25 Oct 2012, Linus Walleij wrote:
> 
> >> Probably some driver is needing a clk_get() or a clk_get_sys() is
> >> needs to be added somewhere to bring up some vital cluster,
> >> or there may be some out-of-tree driver needed to bring up the
> >> cluster properly I have no clue... Maybe some cluster just
> >> cannot be declocked like that.
> >
> > I leave work in 10 mins and won't be coding again for ~2.5 weeks.
> > So if this is something you could squeeze in and fix-up, I'd be
> > very grateful.
> 
> I'll try. It doesn't look right that a clk_prepare() in the pinctrl
> driver is saving the day for somebody else...

Hi Linus,

Did you apply this in the end?

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
