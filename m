From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Mar 2011 11:42:11 -0800
Subject: [PATCH] omap2+: mux: Remove the use of IDLE flag.
In-Reply-To: <1299656738-7885-1-git-send-email-r.sricharan@ti.com>
References: <1299656738-7885-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20110309194211.GO26463@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* sricharan <r.sricharan@ti.com> [110308 23:43]:
> Currently OMAP_DEVICE_PAD_IDLE flag is used to mux pins
> dynamically. This can be simplified by using the enabled
> state variable of each pad. This also fixes the issue of
> the static pads not getting muxed after idling and
> disable/enable state transitions.

Thanks applying.

Tony
