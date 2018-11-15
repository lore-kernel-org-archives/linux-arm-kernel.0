From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Nov 2018 06:25:44 -0800
Subject: [PATCH] ARM: shmobile: sh73a0: Remove obsolete inclusion of
 <asm/smp_twd.h>
In-Reply-To: <20181115095731.17362-1-geert+renesas@glider.be>
References: <20181115095731.17362-1-geert+renesas@glider.be>
Message-ID: <20181115142543.do5lfjolppnzspin@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:57:31AM +0100, Geert Uytterhoeven wrote:
> As of commit 9a9863987bf7307f ("ARM: shmobile: Remove legacy SoC code
> for SH-Mobile AG5"), this header file is no longer used.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert,

applied for v4.21.
