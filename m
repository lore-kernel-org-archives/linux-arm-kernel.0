From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 2 Apr 2015 10:18:52 +0200
Subject: [PATCH] pinctrl: dt: at91: new binding
In-Reply-To: <CAOesGMgsyEwuF95FFe81Li8nXO0MhHF0ZHPVV91MEH-JGO43tA@mail.gmail.com>
References: <1424943294-8805-1-git-send-email-plagnioj@jcrosoft.com>
 <CACRpkdbNLE+VjhvSgsU4oqAc03ieCNyiLkUzbjEiu_LFof-Unw@mail.gmail.com>
 <CAOesGMgsyEwuF95FFe81Li8nXO0MhHF0ZHPVV91MEH-JGO43tA@mail.gmail.com>
Message-ID: <20150402081852.GA26864@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:55 Sun 29 Mar     , Olof Johansson wrote:
> On Tue, Mar 17, 2015 at 5:07 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Thu, Feb 26, 2015 at 10:34 AM, Jean-Christophe PLAGNIOL-VILLARD
> > <plagnioj@jcrosoft.com> wrote:
> >
> >> +For each peripheral/bank we will descibe in a u32 if a pin can be
> >> +configured in it by putting 1 to the pin bit (1 << pin)
> >
> > This seems to be describing driver intrinsics in the device tree, like
> > how the hardware is routed on the inside and what it can do.
> >
> > IMO that is driver territory, the driver should know these limitations
> > and protest if you try to do something illegal.
> >
> > Anyway as the AT91 maintainers seem to disagree I will allow some
> > more time for discussion before merging the patch.
> >
> > I can't really have one AT91 maintainer NACKing another, it doesn't
> > matter that this is a separate driver, in my book the MAINTAINERS
> > entry for AT91 as a whole overrides that so can you please find an
> > agreement on how to handle this or I will stall the patch until
> > you're in agreement.
> 
> Nicolas has been the de-facto maintainer of AT91 for quite a while
> now, even though more of them are listed on the maintainers entry. It
> would be inappropriate to merge something that he disagreed with on
> that platform.
I'm still following it
> 
> > ARM SoC maintainers input would be welcomed.
> 
> It seems appropriate to ask the at91 folks to come back with a
> solution that everybody is OK with, and until then hold off merging
> this.
when the nack is motivated not just I don't like it

Best Regards,
J.
