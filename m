From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Jun 2015 12:41:12 +0900
Subject: [PATCH 2/2] ARM: shmobile: timer: r8a73a4 and r8a7790 are
 multi-platform only
In-Reply-To: <1434533661-22730-2-git-send-email-geert+renesas@glider.be>
References: <1434533661-22730-1-git-send-email-geert+renesas@glider.be>
 <1434533661-22730-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20150619034112.GC22912@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 11:34:21AM +0200, Geert Uytterhoeven wrote:
> Since commits e042681894b62d60 ("ARM: shmobile: r8a7790: Remove legacy
> code") and 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
> legacy platform"), the R-Mobile APE6 and R-Car H2 SoCs are supported by
> multiplatform kernels only.
> Hence we can drop checks for these SoCs in legacy kernel builds.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
