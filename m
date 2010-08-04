From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Aug 2010 13:15:07 +0300
Subject: [PATCH 4/5] [omap1] Bluetooth device code common to HTC
	smartphones
In-Reply-To: <1280762976-17284-5-git-send-email-darkstar6262@gmail.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
	<1280762976-17284-5-git-send-email-darkstar6262@gmail.com>
Message-ID: <20100804101507.GG9881@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
> This change adds in a bluetooth controld driver/rfkill
> interface to the serial bluetooth controller found on many
> HTC smartphones such as the HTC Herald and HTC Wizard.

To me it looks like most of this should be in drivers/bluetooth/omap7xx.c
or something like that. Then you can just pass it the gpio numbers in
the platform_data.
 
Regards,

Tony
