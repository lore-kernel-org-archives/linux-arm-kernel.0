From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Apr 2014 12:27:17 +0100
Subject: [PATCH v4 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry
 macro for iteration
In-Reply-To: <6612075.PRZcWcuj98@vostro.rjw.lan>
References: <534DB213.7080802@semaphore.gr> <5355A349.50908@semaphore.gr>
 <20140422071541.GA17657@lee--X1>
 <6612075.PRZcWcuj98@vostro.rjw.lan>
Message-ID: <20140422112717.GA21613@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Apr 2014, Rafael J. Wysocki wrote:

> On Tuesday, April 22, 2014 08:15:41 AM Lee Jones wrote:
> > > The cpufreq core now supports the cpufreq_for_each_entry macro helper
> > > for iteration over the cpufreq_frequency_table, so use it.
> > > 
> > > It should have no functional changes.
> > 
> > > Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> > > ---
> > 
> > It would be good to have a changelog which describes the differences
> > between the versions, so we can keep track.
> > 
> > >  drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------
> > >  1 file changed, 8 insertions(+), 11 deletions(-)
> > 
> > So it looks like I already applied v2 of this patch to my tree. What
> > changed in v3 and v4? Should I remove that patch from MFD and apply
> > this one instead?
> 
> The reason why v4 was sent is because I asked for it.
> 
> And if you applied [5/8] without [1/8], it won't work, because the macro is
> introduced by that patch.

That's right, which is why I mailed you about it:

  > > > Applied untested by me.
  > >
  > > Wouldn't build. Let it go via Rafael.
  >
  > Rafael, would you mind creating a branch from this patch set that we
  > can both pull from please?

> If that's the case, please drop [5/8] and let me handle the entire series.

I'm happy for you to apply the series and send me a pull-request for
either a) the entire series or b) just the patches which touch MFD and
any subsequent decencies. Or I can apply them and send you one.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
