From: hans-christian.egtvedt@atmel.com (Hans-Christian Egtvedt)
Date: Tue, 26 Apr 2011 14:22:12 +0200
Subject: [PATCH 11/14] PM / AVR32: Use struct syscore_ops instead of
	sysdevs for PM
In-Reply-To: <201104172313.09712.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl>
	<201104172301.54115.rjw@sisk.pl>  <201104172313.09712.rjw@sisk.pl>
Message-ID: <1303820532.3125.12.camel@hcegtvedt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-04-17 at 23:13 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Convert some AVR32 architecture's code to using struct syscore_ops
> objects for power management instead of sysdev classes and sysdevs.
> 
> This simplifies the code and reduces the kernel's memory footprint.
> It also is necessary for removing sysdevs from the kernel entirely in
> the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

Thanks, nice work. Tested and run on hardware.

<snipp>

-- 
Hans-Christian Egtvedt
