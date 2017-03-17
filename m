From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Mar 2017 08:41:57 -0700
Subject: [PATCHv2 6/9] ARM: OMAP2+: timer: add support for fetching fck
 handle from DT
In-Reply-To: <1489741781-12816-7-git-send-email-t-kristo@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-7-git-send-email-t-kristo@ti.com>
Message-ID: <20170317154156.GV20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170317 02:12]:
> The mux clock handle shall be provided via "fck" DT handle. This avoids
> the need to lookup the main clock via hwmod core, which will not work
> with the clkctrl clock support anymore; the main clock is not going to
> be a mux.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
