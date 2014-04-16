From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 16 Apr 2014 15:03:51 +0100
Subject: [PATCH v2 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry
 macro for iteration
In-Reply-To: <CAKohpongiw9kZJDBsnp4U5obzX_W-sWHX3GoKd3STtQmsw6GcA@mail.gmail.com>
References: <534DB213.7080802@semaphore.gr> <20140416105121.GR4754@lee--X1>
 <CAKohpongiw9kZJDBsnp4U5obzX_W-sWHX3GoKd3STtQmsw6GcA@mail.gmail.com>
Message-ID: <20140416140351.GE19671@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> The cpufreq core now supports the cpufreq_for_each_entry macro helper
> >> for iteration over the cpufreq_frequency_table, so use it.
> >>
> >> It should have no functional changes.
> >>
> >> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> >> ---
> >>  drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------
> >>  1 file changed, 8 insertions(+), 11 deletions(-)
> >
> > Applied untested by me.
> 
> Wouldn't build. Let it go via Rafael.

Rafael, would you mind creating a branch from this patch set that we
can both pull from please?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
