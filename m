From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Jun 2013 12:25:49 -0400
Subject: [PATCH] ARM: Kirkwood add cpus definition needed by cpufreq
 driver to dtsi
In-Reply-To: <51ABC056.5000804@baker-net.org.uk>
References: <51ABC056.5000804@baker-net.org.uk>
Message-ID: <20130603162549.GK3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 10:59:50PM +0100, Adam Baker wrote:
> The Kirkwood CPU Freq driver needs a CPU definition in order for the probe
> routine to activate it. Add a suitable definition to kirkwood.dtsi
> 
> This definition is only correct for single core SoCs. There is a dual core
> SoC in the kirkwood family (88F632X) but the rest of the Kirkwood drivers in
> the kernel don't currently support it. If they ever do the cpus definition
> would need to be duplicated in each of the SoC specific include files.
> 
> Signed-off-by: Adam Baker <linux@baker-net.org.uk>

hmm, diffstat is missing.  Please make sure you are using git
format-patch properly in the future.

After cleaning up some minor whitespace (needed leading tabs), applied
to mvebu/dt

thx,

Jason.
