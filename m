From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Feb 2013 13:09:00 -0500
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <20130205180705.5231effd@skate>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130205123827.GG20242@lunn.ch>
 <20130205124833.GS14746@titan.lakedaemon.net>
 <20130205142720.GB2481@localhost>
 <20130205153135.GU14746@titan.lakedaemon.net>
 <20130205171701.4fcb1304@skate>
 <51113132.6000500@free-electrons.com>
 <20130205180705.5231effd@skate>
Message-ID: <20130205180900.GY14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 06:07:05PM +0100, Thomas Petazzoni wrote:
> Of course, it doesn't make sense to have drivers for pluggable devices
> like PCIe devices that are not soldered, USB devices and things like
> that. But for all the rest, I would say it should be in the defconfig.

hmmm, so for the new devboard we should set CONFIG_RAM=n? ;-)

thx,

Jason.
