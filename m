From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 4 Jun 2013 15:13:42 +0100
Subject: [PATCH v2 1/4] clocksource: dw_apb_timer_of: enable the use the
 clocksource as sched clock
In-Reply-To: <201306041137.03319.heiko@sntech.de>
References: <201306041136.09566.heiko@sntech.de>
 <201306041137.03319.heiko@sntech.de>
Message-ID: <20130604141342.GA5308@maple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks goot to me, Heiko!

On Tue, Jun 04, 2013 at 11:37:02AM +0200, Heiko St?bner wrote:
> Currently the dw_apb_timer always expects a separate special timer to be
> availbable for the sched_clock. Some devices using dw_apb_timers do not
> have this sptimer but can use the clocksource as sched_clock instead.
> 
> Therefore enable the driver to distiguish between devices with and without
> sptimer based on the devicetree data and select the correct timer as
> sched_clock.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Jamie Iles <jamie@jamieiles.com>
