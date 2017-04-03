From: horms@verge.net.au (Simon Horman)
Date: Mon, 3 Apr 2017 06:29:37 -0400
Subject: [PATCH v2 0/3] soc: renesas: rcar-sysc: Add support for R-Car H3
 ES2.0
In-Reply-To: <1490950916-9576-1-git-send-email-geert+renesas@glider.be>
References: <1490950916-9576-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170403102936.GG31988@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 11:01:53AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds power domain support for R-Car H3 ES2.0, which
> differs from ES1.x in some areas.
> 
> The goal is twofold:
>   1. Support both the ES1.x and ES2.0 SoC revisions in a single binary
>      for now,
>   2. Make it clear which code supports ES1.x, so it can easily be
>      identified and removed later, when production SoCs are deemed
>      ubiquitous.
> 
> This is achieved by detecting the SoC revision at runtime using the
> soc_device_match() API, and fixing up the power area table to match the
> actual SoC revision.
> 
> Changes compared to v1:
>   - Minor changes to the patch descriptions.
> 
> As PM Domains are initialized quite early, the Renesas SoC device must
> be initialized earlier, and this series thus depends on the pull
> request "[git pull] base: soc: Improvements for the SoC bus and
> soc_device_match()" I've just sent.
> 
> For testers, this series and its dependencies are available in the
> topic/r8a7795es2-sysc-v2 branch of my renesas-drivers git repository at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> An integration branch for testing on the R-Car H3 ES2.0 based Salvator-X
> development board is provided as topic/r8a7795es2-integration.
> 
> This has been tested on Salvator-X with R-Car H3 ES1.0, ES1.1, and ES2.0
> SoCs.
> 
> Thanks for applying!

Thanks, done.
