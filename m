From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Jul 2014 04:50:10 -0700
Subject: [PATCH v3] ARM: dts: am335x-evmsk: enable display and lcd panel
 support
In-Reply-To: <53B3E731.5030604@ti.com>
References: <1404248420-10086-1-git-send-email-detheridge@ti.com>
 <20140701210812.GN13396@saruman.home>
 <20140702074508.GT28884@atomide.com> <53B3E731.5030604@ti.com>
Message-ID: <20140702115010.GW28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140702 04:06]:
> On 02/07/14 10:45, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [140701 14:10]:
> >> Hi,
> >>
> >> On Tue, Jul 01, 2014 at 04:00:20PM -0500, Darren Etheridge wrote:
> >>> Add the necessary nodes to enable the LCD controller and the
> >>> LCD panel that is attached to the Texas Instruments AM335x
> >>> EVMSK platform.  Also setup the necessary pin mux within the
> >>> DT file to drive the LCD connector and add the correct
> >>> pinmux settings for the lcd pins to be configured to when
> >>> the SoC goes into sleep state for the minimum power
> >>> consumption.
> >>>
> >>> For the sleep mode LCD pin settings, MUX_MODE7 is chosen as
> >>> this corresponds to switching the pins into input GPIO's with
> >>> an internal pulldown.  Which has been determined to offer the
> >>> lowest power solution vs leaving the pins configured in LCD
> >>> mode.
> >>>
> >>> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> >>> Acked-by: Wolfram Sang <wsa@sang-engineering.com>
> >>
> >> Tested-by: Felipe Balbi <balbi@ti.com>
> >>
> >> serial console capture: http://slexy.org/view/s200thiMb3
> >>
> >> note that v2 has been pending since May 9th:
> >> http://marc.info/?l=linux-omap&m=139966159102339&w=2
> >>
> >>> ---
> >>> Tony, Benoit,
> >>>
> >>> I didn't see this patch get applied anywhere, so I updated it and I am
> >>> resending it.  Please let me know if you need any more info before you will
> >>> apply it.
> > 
> > Tomi, do you want to ack this one or want to queue the panel .dts
> > changes into a separate branch?
> 
> I don't really have experience with the LCDC used on AM335x SoC (it
> doesn't have DSS), but the patch looks ok, so for what it's worth:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> I don't have any .dts changes queued, so I think it's better if you pick
> it up.

OK thanks applying into omap-for-v3.17/dt.

Regards,

Tony
