From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Aug 2010 13:13:28 +0300
Subject: [PATCH 3/5] [omap1] omap7xx clocks, mux, serial fixes
In-Reply-To: <1280762976-17284-4-git-send-email-darkstar6262@gmail.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
	<1280762976-17284-4-git-send-email-darkstar6262@gmail.com>
Message-ID: <20100804101328.GF9881@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
> This change adds in the necessary clocks and mux pins for UART
> control on omap7xx devices.  I also made a change in the serial
> code to only try and initialize two UARTs in omap_serial_init, as
> these devices don't have three.

This I have already queued up in omap-for-linus.

Regards,

Tony
