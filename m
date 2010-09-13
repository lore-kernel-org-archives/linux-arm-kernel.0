From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 13 Sep 2010 08:50:25 +0100
Subject: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
In-Reply-To: <SNT125-W35B89F6AA83C8DD22E7946BA770@phx.gbl>
References: <cover.1284357372.git.matt@console-pimps.org>
	<SNT125-W35B89F6AA83C8DD22E7946BA770@phx.gbl>
Message-ID: <20100913075025.GA14882@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 09:13:32AM +0200, Marc Titinger wrote:
> 
> Hi, 
> 
> I'm just being curious : do these patches change the way those chips
> should be supported, that do not have a PMU-like IP, but implement
> PC-sampling thanks to a general purpose timer (not the system timer)
> ?

CPUs that do not have a PMU are not required to use the perf-events
oprofile backend, it is entirely optional. The pc-sampling timer in
oprofile is not affected by this series.
