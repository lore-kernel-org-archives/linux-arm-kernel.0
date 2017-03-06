From: naveen.n.rao@linux.vnet.ibm.com (Naveen N. Rao)
Date: Mon, 6 Mar 2017 23:37:20 +0530
Subject: [PATCH 2/3] arm: kprobes: remove kprobe_exceptions_notify
In-Reply-To: <46a640f65b86650d3a7d64a577dd441838de1c20.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <46a640f65b86650d3a7d64a577dd441838de1c20.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <20170306180720.GC7467@naverao1-tp.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/02/08 01:24AM, Naveen N Rao wrote:
> ... as the weak variant will do.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/arm/probes/kprobes/core.c     | 10 ----------
>  arch/arm64/kernel/probes/kprobes.c |  6 ------
>  2 files changed, 16 deletions(-)

With the generic changes in this series now in -rc1, can you please pick 
this up?

Thanks,
Naveen
