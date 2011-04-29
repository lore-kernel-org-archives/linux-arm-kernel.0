From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 Apr 2011 21:32:53 +0200
Subject: [PATCH v2 02/23] at91: Make Ethernet device common
In-Reply-To: <20110428183132.GH17290@n2100.arm.linux.org.uk>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-3-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D24302CC@AUSP01VMBX24.collaborationhost.net>
	<20110428091517.GP17290@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B027084269764D26C44B4@AUSP01VMBX24.collaborationhost.net>
	<20110428183132.GH17290@n2100.arm.linux.org.uk>
Message-ID: <20110429193252.GY31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Apr 28, 2011 at 07:31:32PM +0100, Russell King - ARM Linux wrote:
> There was talk a while ago about getting rid of the pointer-ness of
> dma_mask, but I think there's a bit of historic baggage in there to do
> with the pre-device model PCI bus support code which gets in the way.
> Not too sure about that though.
Here is some more info:

	http://thread.gmane.org/gmane.linux.kernel.pci/9081

The long story short (IIRC): it's ugly but not worth to be cleaned up.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
