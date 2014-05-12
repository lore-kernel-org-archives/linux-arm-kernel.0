From: horms@verge.net.au (Simon Horman)
Date: Mon, 12 May 2014 16:10:24 +0900
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7791
In-Reply-To: <20140511232508.20177.11556.sendpatchset@w520>
References: <20140511232508.20177.11556.sendpatchset@w520>
Message-ID: <20140512071022.GB20505@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 08:25:08AM +0900, Magnus Damm wrote:
> ARM: shmobile: Use shmobile_init_delay() on r8a7791
> 
> [PATCH 01/03] ARM: shmobile: Use r8a7791 DT CPU Frequency in common case	
> [PATCH 02/03] ARM: shmobile: Use r8a7791 DT CPU Frequency for Koelsch
> [PATCH 03/03] ARM: shmobile: Remove unused r8a7791_init_early()
> 
> Convert r8a7791 to rely on shmobile_init_delay() instead of using a per-SoC
> delay setup function.

Thanks, I will queue this up.
