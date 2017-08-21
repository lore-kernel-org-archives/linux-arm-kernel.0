From: horms@verge.net.au (Simon Horman)
Date: Mon, 21 Aug 2017 11:06:13 +0200
Subject: [PATCH v2 0/4] ARM: dts: rcar-gen2: Stop grouping clocks under a
 "clocks" subnode
In-Reply-To: <1503047817-29439-1-git-send-email-geert+renesas@glider.be>
References: <1503047817-29439-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170821090613.GF14174@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 11:16:53AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> The current practice is to not group clocks under a "clocks" subnode,
> but just put them together with the other on-SoC devices.
> 
> Hence this patch series implements this for the various R-Car Gen2
> DTSes that still need this (r8a7792.dtsi is OK).
> 
> Changes compared to v1:
>   - Rebased.
> 
> Dependencies:
>   - renesas-devel-20170818-v4.13-rc5,
>   - Patch series "[PATCH v2 0/5] ARM: dts: rcar-gen2: Convert to new
>     CPG/MSSR bindings".
> 
> For your convenience, this series is also available in the
> topic/rcar2-cpg-mssr-dt-v2 branch of my renesas-drivers git repository at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (4):
>   ARM: dts: r8a7790: Stop grouping clocks under a "clocks" subnode
>   ARM: dts: r8a7791: Stop grouping clocks under a "clocks" subnode
>   ARM: dts: r8a7793: Stop grouping clocks under a "clocks" subnode
>   ARM: dts: r8a7794: Stop grouping clocks under a "clocks" subnode

Thanks. r8a779[034] patches applied for v4.15.

The r8a7791 patch did not apply cleanly for some reason.
Could you rebase and repost once I have pushed today's devel branch?
