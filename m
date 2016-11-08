From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 8 Nov 2016 21:11:14 +0100
Subject: [PATCH 1/1 v7] ARM: imx: Added perf functionality to mmdc driver
In-Reply-To: <CAHrpEqQGRLY7ZB6moP9FZ0w-t63QkyLE1fUb3heRZJfRd2Y9sw@mail.gmail.com>
References: <1474307267-3081-1-git-send-email-Frank.Li@nxp.com>
 <CAP=VYLo_p3ZmOFcyM9om_31-=5O3ZiRLCBkJDDtj84JxAA7h8Q@mail.gmail.com>
 <CAHrpEqQGRLY7ZB6moP9FZ0w-t63QkyLE1fUb3heRZJfRd2Y9sw@mail.gmail.com>
Message-ID: <20161108201114.GQ3117@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 01:21:47PM -0600, Zhi Li wrote:
> On Tue, Nov 8, 2016 at 1:00 PM, Paul Gortmaker
> > I just noticed this commit now that linux-next is back after the week off.
> >
> > This should probably use core_param or setup_param since the Kconfig
> > for this is bool and not tristate. 


> I think pmu_pmu_poll_period_us should be removed because no benefit to
> change it.
> I can delete .remove

Why not make it tristate ?
