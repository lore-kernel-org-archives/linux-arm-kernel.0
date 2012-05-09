From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 8 May 2012 20:52:24 -0400
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <87sjfap57x.fsf@laptop.org>
References: <8762cdur7o.fsf@laptop.org> <4FA3D720.7010004@linaro.org>
 <87mx5ot6vp.fsf@laptop.org> <4FA3DC27.6030204@linaro.org>
 <CAP=VYLoLgLmwWTWrJrMBCRLD_BjupjmfV2me6TDeej=ZS=W7hw@mail.gmail.com>
 <4FA90127.1050107@linaro.org> <878vh2rhlh.fsf@laptop.org>
 <4FA918BA.3080303@linaro.org>
 <CAP=VYLoz0o7qh9TNgWPatAsSjtoKoyaBUW7L+3q1w0PsLkOMOQ@mail.gmail.com>
 <87sjfap57x.fsf@laptop.org>
Message-ID: <20120509005224.GB6681@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500] On 08/05/2012 (Tue 20:29) Chris Ball wrote:

> Hi Paul,
> 
> On Tue, May 08 2012, Paul Gortmaker wrote:
> > On Tue, May 8, 2012 at 8:59 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >> Here you go Chris.
> >>
> >> From: Lee Jones <lee.jones@linaro.org>
> >> Date: Tue, 8 May 2012 13:40:02 +0100
> >> Subject: [PATCH] MMC: mmci: Fix compiler error when CONFIG_OF is not set
> >>
> >> error: implicit declaration of function 'mmci_dt_populate_generic_pdata'
> >>
> >> This is due to the '#if CONFIG_OF' guards placed around
> >> mmci_dt_populate_generic_pdata(), but not around the call to it. We
> >> repair this by inserting a stub which elegantly returns when CONFIG_OF
> >> is not set.
> >>
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > Please if possible, do not neglect to add the Reported-by: line when
> > appropriate.  I've been at this long enough that it really won't change
> > my life any if it is there or not there, but for someone new to linux, it
> > might make the difference between an "I'm glad I reported that" vs.
> > a "Screw them, I'm not reporting anything else in the future."
> 
> Agreed -- I added a Reported-by line when I applied the patch:
> 
> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=c0a120a4bc68f5dc5f5238e76013cc18bac0ffed

Cool, thanks Chris -- you may not hear it, but I'm sure you've
implicitly helped keep people involved in the triage process.

Paul.
--

> 
> Thanks,
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
