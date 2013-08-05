From: horms@verge.net.au (Simon Horman)
Date: Mon, 5 Aug 2013 17:35:55 +0900
Subject: [PATCH 02/02] ARM: shmobile: Per-CPU SMP boot / sleep code for
 SCU SoCs
In-Reply-To: <20130731183827.31551.83583.sendpatchset@w520>
References: <20130731183808.31551.47235.sendpatchset@w520>
 <20130731183827.31551.83583.sendpatchset@w520>
Message-ID: <20130805083553.GC13274@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 03:38:27AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Hook in the per-CPU boot and sleep code in the shared
> mach-shmobile SCU code. CPUs may be kept in the asm
> routine until ->boot_secondary() when the per-CPU
> boot vector is installed. At the end of ->die() the
> asm sleep routine is invoked.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in the smp branch.
