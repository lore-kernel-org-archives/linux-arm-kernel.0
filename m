From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 12 Mar 2012 11:53:15 +0200
Subject: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
In-Reply-To: <alpine.DEB.2.00.1203092355280.27395@utopia.booyaka.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
 <4F5A258F.8050704@ti.com> <20120309180027.GF12083@atomide.com>
 <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com>
 <alpine.DEB.2.00.1203091103450.7039@utopia.booyaka.com>
 <alpine.DEB.2.00.1203092355280.27395@utopia.booyaka.com>
Message-ID: <4F5DC78B.2060203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

On 03/10/2012 09:08 AM, Paul Walmsley wrote:
> 
> Hello P?ter
> 
> could you please try this patch instead of the clkdev change?
> 
> It is based on my 'hwmod_enable_remaining_hwmods_devel_3.4' branch, but 
> the basic idea should work on v3.3-rc6 as well.
> 
> If it works for you, please let us know and we can queue this up along 
> with the hwmod data changes.  Probably we should replace the changelog 
> also with the one from your patch, it might be a little more useful?  
> Suggestions welcome.

Unfortunately I can not test the McBSP on OMAP4 at the moment. The patch
looks good, and as far as I can see it will be perfect for OMAP4.
Thank you.
In case you need:

> From: Paul Walmsley <paul@pwsan.com>
> Date: Fri, 9 Mar 2012 23:28:28 -0700
> Subject: [PATCH] ARM: OMAP4: hwmod data: add McBSP parent clock aliases
> 
> Add optional parent clocks for the OMAP4 McBSP modules so the driver
> can switch between parent clocks.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
