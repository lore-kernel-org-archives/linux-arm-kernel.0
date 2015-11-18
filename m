From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 18 Nov 2015 08:25:08 +0100
Subject: [PATCH v2 4/7] ARM: at91/dt: sama5d2: add pio controller node
In-Reply-To: <CAOesGMhOmqr15Ou_QgJuiWdn6wWFYYLmy6eyf6zOopj8tKcadA@mail.gmail.com>
References: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
 <1442417823-15850-5-git-send-email-ludovic.desroches@atmel.com>
 <CACRpkdapS-Vi_F-MqOFOPTHa2+zbrsPfPsbQA-Eks+tR3Wjg2A@mail.gmail.com>
 <CAOesGMhXtACRaTurWfQgHNr_mU+VF9TjQJz5wQ4RsSVS+WZ0cA@mail.gmail.com>
 <CACRpkdbhFi531Dm9AgOGhc7XHnnyJ+L3t0FvHOPV-fC2f9X6QQ@mail.gmail.com>
 <CAOesGMhOmqr15Ou_QgJuiWdn6wWFYYLmy6eyf6zOopj8tKcadA@mail.gmail.com>
Message-ID: <20151118072508.GK16931@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 11:15:11AM -0800, Olof Johansson wrote:
> On Tue, Nov 17, 2015 at 3:06 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Nov 10, 2015 at 1:30 AM, Olof Johansson <olof@lixom.net> wrote:
> >> On Mon, Sep 21, 2015 at 11:24 AM, Linus Walleij
> >> <linus.walleij@linaro.org> wrote:
> >>> On Wed, Sep 16, 2015 at 8:37 AM, Ludovic Desroches
> >>> <ludovic.desroches@atmel.com> wrote:
> >>>
> >>>> Add pio4 controller node to enable pinmux and gpio.
> >>>>
> >>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>>
> >>> Patch applied.
> >>
> >> Please don't merge DT changes through driver trees unless there's a
> >> very specific reason to do so, since it introduces random conflicts.
> >
> > Sorry :(
> >
> > Even noted this in the pull request to Torvalds, it was in the bottom
> > of my patch stack so had been in -next for ages, I was afraid it
> > would create more problem than it solves if I reverted the patch,
> > but I guess I should have done so anyways.
> 
> Yeah, it's OK -- I spotted that pull request later as well.
> 
> It's not a big deal in most specific instances, I'd say. It's just in
> aggregate it becomes a bother.
> 
> So, just see this as a public reminder since we've seen it creep into
> other driver trees a bit more lately. Mistakes will still happen but
> try to keep it down. And for those who submit patches, feel free to
> point out in the patch that you don't expect the driver/subsystem
> maintainer to apply it to help them out.
> 

Ok. Sorry, I didn't think it could cause so many conflicts if not taken
by Nicolas.


Ludovic
