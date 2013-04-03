From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Apr 2013 15:01:18 -0700
Subject: [PATCH 00/21] Various fixes and extensions to Exynos4 clock
 driver
In-Reply-To: <22e101ce2f7c$5b6a0cd0$123e2670$%kim@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
 <CAJuYYwQap4pZ6qTgBPGeSWbMFm-ZhqLfv7wBMVYjK1v0YHr_kQ@mail.gmail.com>
 <1496108.NDegb7PXrt@flatron>
 <22e101ce2f7c$5b6a0cd0$123e2670$%kim@samsung.com>
Message-ID: <20130403220118.3383.10734@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kukjin Kim (2013-04-02 01:30:39)
> Tomasz Figa wrote:
> > 
> > On Saturday 30 of March 2013 15:33:00 Thomas Abraham wrote:
> > > Hi Tomasz,
> > >
> > > On 27 March 2013 16:32, Tomasz Figa <t.figa@samsung.com> wrote:
> > > > This series is a collection of various fixes and extensions to Exynos4
> > > > clock driver, which improve coverage of clocks present on Exynos4 SoCs
> > > > and fix problems discovered during our internal work and testing.
> > >
> > > Nice series. Thanks for the improvements and fixes. Looking at the
> > > second patch in this series, I crossed checked again with the
> > > Exynos4412 user manual that I have. Your modifications are different
> > > from what the manual has listed. I suspect, you have a newer copy of
> > > the manual.
> > 
> > Right. I have checked revisions 0.0, 0.1 and 1.1 of the manual and indeed
> > there are differences in clock layout between 0.1 and 1.1. My patches are
> > based on revision 1.1.
> > 
> Correct...hmm...
> 
> > > For this series:
> > > Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
> > 
> Yes, looks good to me but would be better if I could get Mike's ack on this
> series.
> 

Acked-by: Mike Turquette <mturquette@linaro.org>

> Thanks.
> 
> - Kukjin
