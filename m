From: gxt@mprc.pku.edu.cn (Guan Xuetao)
Date: Tue, 19 Apr 2011 16:02:55 +0800
Subject: [PATCH 12/14] PM / UNICORE32: Use struct syscore_ops instead of
	sysdevs for PM
In-Reply-To: <201104172313.45854.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
	<201104172313.45854.rjw@sisk.pl>
Message-ID: <006201cbfe68$3ad01380$b0703a80$@mprc.pku.edu.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw at sisk.pl]
> Sent: Monday, April 18, 2011 5:14 AM
> To: LKML
> Cc: Greg KH; Kay Sievers; Linux PM mailing list; Russell King; linux-omap at vger.kernel.org; Kevin Hilman; linux-arm-
> kernel at lists.infradead.org; Ben Dooks; Mike Frysinger; Ralf Baechle; Hans-Christian Egtvedt; Guan Xuetao; Benjamin Herrenschmidt;
> linuxppc-dev at lists.ozlabs.org; Jiri Kosina; Konrad Rzeszutek Wilk; Jeremy Fitzhardinge
> Subject: [PATCH 12/14] PM / UNICORE32: Use struct syscore_ops instead of sysdevs for PM
> 
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make some UNICORE32 architecture's code use struct syscore_ops
> objects for power management instead of sysdev classes and sysdevs.
> 
> This simplifies the code and reduces the kernel's memory footprint.
> It also is necessary for removing sysdevs from the kernel entirely in
> the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
