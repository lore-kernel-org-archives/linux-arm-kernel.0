From: horms@verge.net.au (Simon Horman)
Date: Tue, 9 Feb 2016 20:25:46 +0100
Subject: [PATCH] ARM: shmobile: r8a7740: Remove obsolete #include
 <asm/hardware/cache-l2x0.h>
In-Reply-To: <1455043504-27933-1-git-send-email-geert+renesas@glider.be>
References: <1455043504-27933-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160209192546.GD12049@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 07:45:04PM +0100, Geert Uytterhoeven wrote:
> As of commit 540977ae9746e60c ("ARM: shmobile: r8a7740: Migrate to
> generic l2c OF initialization"), no l2x0 functionality is used from
> platform code, so the include can be removed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> As you plan to respin renesas-dt-for-v4.6, perhaps this can still be
> folded in the original commit?

Thanks, I have squashed this into the original commit.
