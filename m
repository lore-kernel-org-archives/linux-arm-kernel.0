From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 03 Sep 2014 22:40:07 +0900
Subject: [RESEND PATCH v4 2/2] ARM: EXYNOS: Refactor the pm code to use DT
 based lookup
In-Reply-To: <CAGm_ybhDsGpoHg8XVBOPEv7oHc0YdSZBW_JXB0hZk-y6Bac00g@mail.gmail.com>
References: <1408431167-14134-1-git-send-email-vikas.sajjan@samsung.com>
 <1408431167-14134-3-git-send-email-vikas.sajjan@samsung.com>
 <CAGm_ybjx4t7kGg0mJHjrox39jP-DNgc-0rkLNn2rcOLS6JjAHQ@mail.gmail.com>
 <2186657.jhIisq7Fok@amdc1032>
 <CAGm_ybhDsGpoHg8XVBOPEv7oHc0YdSZBW_JXB0hZk-y6Bac00g@mail.gmail.com>
Message-ID: <02aa01cfc77c$94865f20$bd931d60$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas Sajjan wrote:
> 
> Hi,
> 
Hi,

Sorry for late response...

> On Tue, Aug 19, 2014 at 3:05 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Tuesday, August 19, 2014 01:26:49 PM Vikas Sajjan wrote:
> >> Hi Kukjin,
> >>
> >> On Tue, Aug 19, 2014 at 12:22 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> >> > Refactoring the pm.c to avoid using "soc_is_exynos" checks,
> >> > instead use the DT based lookup.
> >> >
> >> > While at it, consolidate the common code across SoCs
> >> > and create static helper functions.
> >> >
> >> > Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> >> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> >>
> >> Can you pick this series...
> >
> > I think that my PM_SLEEP=n build fixes should go in before this cleanup
> > series:
> 
> Its better for Kukjin to decide which series he wants to pick first.
> 
Hmm...I need to have a look at the Bart's fix then I'll let you know. Maybe
tomorrow morning ;)

> 
> >
> >   http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35430.html
> >

- Kukjin
