From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Jun 2015 12:41:08 +0900
Subject: [PATCH 1/2] ARM: shmobile: R-Car Gen2:
 CONFIG_ARCH_SHMOBILE_MULTI is always set
In-Reply-To: <1434533661-22730-1-git-send-email-geert+renesas@glider.be>
References: <1434533661-22730-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150619034107.GB22912@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 11:34:20AM +0200, Geert Uytterhoeven wrote:
> Since commit e042681894b62d60 ("ARM: shmobile: r8a7790: Remove legacy
> code"), all R-Car Gen2 SoCs are supported by multiplatform kernels only.
> As CONFIG_ARCH_SHMOBILE_MULTI is always set for shmobile multiplatform
> kernels, we can remove related #ifdefs in code specific to R-Car Gen2
> SoCs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
