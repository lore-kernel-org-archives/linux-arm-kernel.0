From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 4 Jun 2013 15:15:26 +0100
Subject: [PATCH v2 2/4] clocksource: dw_apb_timer_of: add clock-handling
In-Reply-To: <201306041137.37036.heiko@sntech.de>
References: <201306041136.09566.heiko@sntech.de>
 <201306041137.37036.heiko@sntech.de>
Message-ID: <20130604141526.GB5308@maple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 11:37:36AM +0200, Heiko St?bner wrote:
> Add the possibility to get the clock-frequency from a timer clock instead
> of specifying it as dt property. Additionally also add the possibility
> to also define a controlling periphal clock for the timer block.
> 
> The clock-frequency property is kept to act as fallback if no clocks
> are specified.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Jamie Iles <jamie@jamieiles.com>
