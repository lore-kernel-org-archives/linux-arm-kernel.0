From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 10 Oct 2012 11:04:13 +0200
Subject: [PATCH 00/16] pinctrl: samsung: Usability and extensibiltiy
 improvements
In-Reply-To: <CACRpkdbUmM2=vhjhCq_qN2v=8RUDeWV4b8A8oXXPE4e8Z9C7zg@mail.gmail.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <CACRpkdbUmM2=vhjhCq_qN2v=8RUDeWV4b8A8oXXPE4e8Z9C7zg@mail.gmail.com>
Message-ID: <2232733.TBZrPdcAAF@amdc1227>
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

As I already stated in my other replies, patches for (2) and (3) depend on 
(1), because current architecture of the driver makes it hard to implement 
in an elegant way, so some code would have to be reworked anyway.

I should still have some preliminary work on this in one of my branches in 
my working tree, but it was heavily incomplete, as it turned out that using 
DT would simplify some things.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
