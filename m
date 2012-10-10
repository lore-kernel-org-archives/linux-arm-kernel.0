From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 10 Oct 2012 17:22:17 +0200
Subject: [PATCH 00/16] pinctrl: samsung: Usability and extensibiltiy
 improvements
In-Reply-To: <CACRpkdbUmM2=vhjhCq_qN2v=8RUDeWV4b8A8oXXPE4e8Z9C7zg@mail.gmail.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <CACRpkdbUmM2=vhjhCq_qN2v=8RUDeWV4b8A8oXXPE4e8Z9C7zg@mail.gmail.com>
Message-ID: <1574970.TNZCJfSix7@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 of October 2012 09:46:28 Linus Walleij wrote:
> On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > This patch series is a work on improving usability and extensibiltiy of
> > the> 
> > pinctrl-samsung driver. It consists of three main parts:
> >  - moving SoC-specific data to device tree
> >  - converting the driver to use one GPIO chip and one IRQ domain per
> >  pin bank - introducing generic wake-up interrupt capability
> >  description
> 
> So can you prepare a patch series which does all but the first
> bullet to begin with, and a SoC-and register offset patch
> on top of that as a separate series, because it is controversial?
> 
> I don't like that these two things are mingled together like this
> in an all-or-nothing manner.
> 
> So I'm OK with a patch series for bulle (2) and (3) but not (1).
> 
> And I'd like to have Thomas A:s ACK on the series too.
> 

I have managed to rework the changes to drop (1). I will send next version 
of patches tomorrow. It would be nice to have them merged for 3.7, as they 
are rather important for further work.

Moving data from the driver to device tree is not as important, so it might 
be discussed later.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
