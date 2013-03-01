From: horms@verge.net.au (Simon Horman)
Date: Fri, 1 Mar 2013 16:25:01 +0900
Subject: [PATCH v4 0/3] R-Car SATA platform data
In-Reply-To: <201302272332.51650.sergei.shtylyov@cogentembedded.com>
References: <201302272332.51650.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130301072501.GE14376@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 11:32:51PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the v4 of the set of now 3 patches (the driver itself has been merged
> since) against the Simon Horman's renesas.git repo, 'next' branch:
> 
> [1/3] ARM: mach-shmobile: r8a7779: SATA DT configuration
> [2/3] ARM: mach-shmobile: r8a7779: add SATA support
> [3/3] ARM: mach-shmobile: marzen: add SATA support
> 
> Patch changes since the initial posting are reported in the individual patches.

Thanks. I have refreshed the topic/r-car-sata branch of the renesas tree
accordingly. That branch still contains a copy of the "Add Renesas R-Car
on-chip 3Gbps SATA controller driver." but it should disappear once I rebase
(e.g. on v3.9-rc1).
