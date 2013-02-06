From: alior@marvell.com (Lior Amsalem)
Date: Wed, 6 Feb 2013 10:10:48 +0200
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <20130205180900.GY14746@titan.lakedaemon.net>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130205123827.GG20242@lunn.ch>
 <20130205124833.GS14746@titan.lakedaemon.net>
 <20130205142720.GB2481@localhost>
 <20130205153135.GU14746@titan.lakedaemon.net>
 <20130205171701.4fcb1304@skate> <51113132.6000500@free-electrons.com>
 <20130205180705.5231effd@skate> <20130205180900.GY14746@titan.lakedaemon.net>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56C3AE316@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Jason Cooper [mailto:jason at lakedaemon.net]
> Sent: Tuesday, February 05, 2013 8:09 PM
> 
> On Tue, Feb 05, 2013 at 06:07:05PM +0100, Thomas Petazzoni wrote:
> > Of course, it doesn't make sense to have drivers for pluggable devices
> > like PCIe devices that are not soldered, USB devices and things like
> > that. But for all the rest, I would say it should be in the defconfig.
> 
> hmmm, so for the new devboard we should set CONFIG_RAM=n? ;-)

I think something like CONFIG_RAM=m suit better :)

> 
> thx,
> 
> Jason.

Regards,
Lior Amsalem
