From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 4 Jun 2013 15:15:54 +0100
Subject: [PATCH v2 3/4] clocksource: dw_apb_timer_of: select DW_APB_TIMER
In-Reply-To: <201306041138.11447.heiko@sntech.de>
References: <201306041136.09566.heiko@sntech.de>
 <201306041138.11447.heiko@sntech.de>
Message-ID: <20130604141554.GC5308@maple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 11:38:11AM +0200, Heiko St?bner wrote:
> dw_apb_timer_of is the driver part facing devicetree platforms and
> calls into dw_apb_timer with the data gathered from the dt.
> 
> Currently the two platforms using the dw_apb_timer_of select both
> the options for the core timer and the dt addon.
> 
> As dw_apb_timer_of always depends on dw_apb_timer let it select
> DW_APB_TIMER itself without the need for every platform to do it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Jamie Iles <jamie@jamieiles.com>
