From: horms@verge.net.au (Simon Horman)
Date: Tue, 1 Nov 2016 10:21:45 +0100
Subject: [PATCH] ARM: dts: r8a7794: remove Z clock
In-Reply-To: <2289596.xFBEUD1OgK@wasted.cogentembedded.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
 <2289596.xFBEUD1OgK@wasted.cogentembedded.com>
Message-ID: <20161101092144.GC28143@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2016 at 12:31:27AM +0300, Sergei Shtylyov wrote:
> R8A7794 doesn't have Cortex-A15 CPUs, thus there's no Z clock...
> 
> Fixes: 0dce5454d5c2 ("ARM: shmobile: Initial r8a7794 SoC device tree")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'master' branch of Simon Horman's 'renesas.git' repo.

Thanks, I have queued this up.
