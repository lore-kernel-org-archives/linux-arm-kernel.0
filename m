From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 14 Oct 2013 19:34:01 +0000 (UTC)
Subject: [PATCH] arm: omap2+: hwmod: Add qspi data for am437x.
In-Reply-To: <1381773742-3931-1-git-send-email-sourav.poddar@ti.com>
References: <1381773742-3931-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <alpine.DEB.2.02.1310141933130.22465@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 14 Oct 2013, Sourav Poddar wrote:

> Add hwmod data for qspi for AM437x.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> This was tested on AM437x EPOS EVM with Afzal's v6 of AM43x PRCM
> basic support and tero's DT clock series.

Could you please rebase this on top of George Cherian's patch:

"[PATCH] ARM: OMAP2+: hwmod: Add USB hwmod data for AM437x."

?


- Paul
