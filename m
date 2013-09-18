From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Sep 2013 19:34:54 -0500
Subject: [PATCH 00/05] ARM: shmobile: Use CPU notifiers for SCU boot
 vector code
In-Reply-To: <20130914134616.19258.27110.sendpatchset@w520>
References: <20130914134616.19258.27110.sendpatchset@w520>
Message-ID: <20130918003453.GA4330@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 14, 2013 at 10:46:16PM +0900, Magnus Damm wrote:
> ARM: shmobile: Use CPU notifiers for SCU boot vector code
> 
> [PATCH 01/05] ARM: shmobile: Add CPU notifier based SCU boot vector code
> [PATCH 02/05] ARM: shmobile: Let sh73a0 rely on SCU CPU notifier
> [PATCH 03/05] ARM: shmobile: Let EMEV2 rely on SCU CPU notifier
> [PATCH 04/05] ARM: shmobile: Let r8a7779 rely on SCU CPU notifier
> [PATCH 05/05] ARM: shmobile: Remove shmobile_smp_scu_boot_secondary()
> 
> This series converts mach-shmobile to use CPU notifiers for boot vector
> setup for SCU based SoCs such as sh73a0, EMEV2 and r8a7779. This
> allows us to remove the shmobile_smp_scu_boot_secondary() function,
> and it is also ground work for the CPUIdle resume path.

Thanks Magnus, I have queued these up for v3.12.
