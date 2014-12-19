From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 19 Dec 2014 23:25:51 +0100
Subject: [PATCH 4/4] PM: Eliminate CONFIG_PM_RUNTIME
In-Reply-To: <7h1tnv2tu9.fsf@deeprootsystems.com>
References: <472992175.g1ArEYGFPo@vostro.rjw.lan>
 <9470157.PyHoGoSGz1@vostro.rjw.lan> <7h1tnv2tu9.fsf@deeprootsystems.com>
Message-ID: <1504884.AVoVpOfIGf@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 19, 2014 01:49:34 PM Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> 
> [...]
> 
> > Fixed up patch is appended, thanks!
> >
> >
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: PM: Eliminate CONFIG_PM_RUNTIME
> >
> > Having switched over all of the users of CONFIG_PM_RUNTIME to use
> > CONFIG_PM directly, turn the latter into a user-selectable option
> > and drop the former entirely from the tree.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> I assume you're planning to get this in early in the v3.19-rc cycle,
> correct?  That way we can hopefully avoid conflicts with the various
> defconfig changes we're taking through the arm-soc tree.

I'm going to send a pull request with these changes tomorrow.

> Also, thanks for taking care of all the tree-wide changes.  This is a
> great change.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
