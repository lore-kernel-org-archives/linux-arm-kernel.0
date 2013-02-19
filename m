From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 12:42:12 +0900
Subject: [PATCH v2 0/4] R-Car SATA driver and platform data
In-Reply-To: <201302182327.46930.sergei.shtylyov@cogentembedded.com>
References: <201302182327.46930.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130219034210.GA7701@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 11:27:46PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the v2 of the set of 4 patches against the Simon Horman's renesas.git
> repo, 'next' branch:
> 
> [1/4] libata: add R-Car SATA driver
> [2/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
> [3/4] ARM: mach-shmobile: r8a7779: add SATA support
> [4/4] ARM: mach-shmobile: marzen: add SATA support
> 
> Patch 1 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git
> repo.
> 
> Patch changes since the initial posting are reported in the individual patches.

Thanks, I have updated topic/r-car-sata and verified
that the SATA driver is successfully initialised for both
non-DT and DT boot.
