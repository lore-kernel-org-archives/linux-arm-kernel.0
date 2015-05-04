From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 May 2015 09:21:34 -0700
Subject: [PATCH 1/2] arm: boot: dts: am437x-sk: fix for new newhaven
 display module revision
In-Reply-To: <1428595167-10050-1-git-send-email-balbi@ti.com>
References: <1428595167-10050-1-git-send-email-balbi@ti.com>
Message-ID: <20150504162134.GL24469@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150409 09:03]:
> AM437x Starter Kit uses a NewHaven Display module with
> a 4.3" display and EDT FT5306 touchscreen
> 
> On that module's new revision, NewHave decided to change
> the pinout on the 6 pin flat-pcb touchscreen connector so
> that instead of having WAKE pin, we now have RESETn.
> 
> The new display module is available on AM437x SK Beta and
> all new revisions while the older revision is only available
> on AM437x SK Alpha which, unfortunately, can't be supported
> anymore in mainline without a revert of this patch.

Applying both into omap-for-v4.1/fixes thanks.

Tony
