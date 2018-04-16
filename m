From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Apr 2018 08:52:59 -0700
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <20180416151732.GU16141@n2100.armlinux.org.uk>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
Message-ID: <20180416155259.GB5671@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [180416 15:19]:
> Since this uses a USB adapter (built onto the board) it could be
> that there could be a bug in the driver for that rather than the
> OMAP4430 SDP, but I've no way to check that hypothesis.

Does it go away when you do a warm reboot of the sdp? Then
it should not be related to the USB iff the ftdi chip is bus
powered by VBUS.

Regards,

Tony
