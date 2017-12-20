From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Dec 2017 09:25:28 +0100
Subject: [PATCH] soc: renesas: rcar-sysc: Mark rcar_sysc_matches[]
 __initconst
In-Reply-To: <1513698884-26663-1-git-send-email-geert+renesas@glider.be>
References: <1513698884-26663-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20171220082527.k7wldjwjxut3j4xz@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 04:54:44PM +0100, Geert Uytterhoeven wrote:
> rcar_sysc_matches[] is used only by rcar_sysc_pd_init(), which is
> __init.  Hence mark rcar_sysc_matches[] __initconst.
> 
> This frees another 1764 bytes (arm32/shmobile_defconfig) or 1000 bytes
> (arm64/renesas_defconfig) of memory after kernel init.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <simon.horman@netronome.com>
