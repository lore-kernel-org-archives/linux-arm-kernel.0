From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 21 Dec 2010 01:15:55 +0900
Subject: [PATCH] ARM: mach-shmobile: Clean up headsmp.S
In-Reply-To: <20101220110450.6824.92672.sendpatchset@t400s>
References: <20101220110450.6824.92672.sendpatchset@t400s>
Message-ID: <20101220161555.GB30700@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 08:04:50PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Use PAGE_OFFSET and PHYS_OFFSET for secondary_startup
> entry point as recommended by Russell King.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Tested on the AG5EVB board using the sh73a0 processor.
> 
>  Applies on top of the rmobile/smp topic branch in sh-2.6 git.
> 
Applied, thanks.
