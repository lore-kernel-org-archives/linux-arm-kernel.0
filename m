From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 26 Apr 2011 19:14:13 +0200
Subject: [PATCH 11/14] PM / AVR32: Use struct syscore_ops instead of
	sysdevs for PM
In-Reply-To: <1303820532.3125.12.camel@hcegtvedt>
References: <201103280125.11750.rjw@sisk.pl> <201104172313.09712.rjw@sisk.pl>
	<1303820532.3125.12.camel@hcegtvedt>
Message-ID: <201104261914.14351.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 26, 2011, Hans-Christian Egtvedt wrote:
> On Sun, 2011-04-17 at 23:13 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Convert some AVR32 architecture's code to using struct syscore_ops
> > objects for power management instead of sysdev classes and sysdevs.
> > 
> > This simplifies the code and reduces the kernel's memory footprint.
> > It also is necessary for removing sysdevs from the kernel entirely in
> > the future.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> 
> Thanks, nice work. Tested and run on hardware.

Thanks!

Rafael
