From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 5 Feb 2013 18:07:05 +0100
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <51113132.6000500@free-electrons.com>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130205123827.GG20242@lunn.ch>
 <20130205124833.GS14746@titan.lakedaemon.net>
 <20130205142720.GB2481@localhost>
 <20130205153135.GU14746@titan.lakedaemon.net>
 <20130205171701.4fcb1304@skate>
 <51113132.6000500@free-electrons.com>
Message-ID: <20130205180705.5231effd@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Tue, 05 Feb 2013 17:20:02 +0100, Gregory CLEMENT wrote:

> So that means we should enable the drivers for all the devices present
> on all the boards?

Yes. For example my mvsdio patch set enables some Wifi driver that
corresponds to a particular SDIO Wifi device that is present in the
Mirabox. But not on other boards.

Of course, it doesn't make sense to have drivers for pluggable devices
like PCIe devices that are not soldered, USB devices and things like
that. But for all the rest, I would say it should be in the defconfig.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
