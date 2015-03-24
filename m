From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 24 Mar 2015 18:05:03 +0000 (UTC)
Subject: [PATCH 1/2] ARM: DRA7: hwmod: Add data for GPTimers 13 through 16
In-Reply-To: <1426539294-28375-2-git-send-email-s-anna@ti.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com>
 <1426539294-28375-2-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1503241804470.16497@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Mar 2015, Suman Anna wrote:

> Add the hwmod data for GPTimers 13, 14, 15 and 16. All these
> timers are present in the L4PER3 clock domain.
> 
> The corresponding DT nodes are already present but disabled.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 96 +++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)

Thanks, queued for v4.1.


- Paul
