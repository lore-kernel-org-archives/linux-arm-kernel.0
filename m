From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 Aug 2010 13:16:15 +0300
Subject: [PATCH 5/5] [htcherald] Add board support for UARTs, bluetooth
In-Reply-To: <1280762976-17284-6-git-send-email-darkstar6262@gmail.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
	<1280762976-17284-6-git-send-email-darkstar6262@gmail.com>
Message-ID: <20100804101614.GH9881@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
> This change adds bluetooth and UART initialization support to the
> HTC Herald board driver.  This allows use of the serial bluetooth
> adapter attached to UART1 using hciattach.

Ah and here you already have the gpio pins in platform_data, nice.
Still, the driver part should be under drivers in the previous patch.

Regards,

Tony
