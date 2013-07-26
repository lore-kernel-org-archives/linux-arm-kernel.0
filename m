From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 26 Jul 2013 14:15:06 +0200
Subject: [PATCH 0/3] arm: zynq: SLCR clean up
In-Reply-To: <1374081015-31431-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1374081015-31431-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <529db7d7-70f5-4dae-8482-cc982c3319cb@VA3EHSMHS026.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 07:10 PM, Soren Brinkmann wrote:
> These are just a few patches cleaning up the driver - well at least I
> find it cleaner this way.
> 3/3 though adds correct read-modify-write for some register accesses.
> The current implementation doesn't seem to do any harm, but this looks
> better, IMHO.
> 
> 	S?ren
> 
> Soren Brinkmann (3):
>   arm: zynq: slcr: Remove redundant header #includes
>   arm: zynq: slcr: Clean up #defines
>   arm: zynq: slcr: Use read-modify-write for register writes
> 
>  arch/arm/mach-zynq/slcr.c | 45 +++++++++++++++++----------------------------
>  1 file changed, 17 insertions(+), 28 deletions(-)

Applied to zynq/cleanup branch.

Thanks,
Michal
