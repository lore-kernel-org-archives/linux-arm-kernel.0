From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 09 Mar 2012 17:45:19 +0200
Subject: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
In-Reply-To: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <4F5A258F.8050704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul, Tony,

On 03/06/2012 10:55 AM, Peter Ujfalusi wrote:
> CLKS signal for McBSP ports can be selected from internal (PRCM) or external
> (ABE_CLKS pin) source.
> To be able to use existing code we need to create clock aliases consistent
> among OMAP2/3/4.

Would you be able to take a look at this patch?

Thanks,
P?ter
