From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Jun 2018 17:09:37 +0200
Subject: [PATCH] ARM: shmobile: rcar-gen2: Stop compiling headsmp-apmu on
 !SMP
In-Reply-To: <20180620085618.dy5vnlhxiajppryy@verge.net.au>
References: <20180619172049.20089-1-geert+renesas@glider.be>
 <20180620085618.dy5vnlhxiajppryy@verge.net.au>
Message-ID: <20180627150936.xwbsppxcewg5qsow@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 10:56:19AM +0200, Simon Horman wrote:
> On Tue, Jun 19, 2018 at 07:20:49PM +0200, Geert Uytterhoeven wrote:
> > As of commit cad160ed0a94927e ("ARM: shmobile: Convert file to use
> > cntvoff"), there's no non-SMP code left in headsmp-apmu.S.
> > 
> > Hence build the file for SMP only, and drop the no longer needed check
> > for CONFIG_SMP inside the file.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks Geert,
> 
> This looks fine to me but I will wait to see if there are other reviews
> before applying.
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied.
