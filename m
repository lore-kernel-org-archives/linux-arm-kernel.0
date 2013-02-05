From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 5 Feb 2013 16:46:10 -0300
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
Message-ID: <20130205194609.GA3670@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 06:07:05PM +0100, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Tue, 05 Feb 2013 17:20:02 +0100, Gregory CLEMENT wrote:
> 
> > So that means we should enable the drivers for all the devices present
> > on all the boards?
> 
> Yes. For example my mvsdio patch set enables some Wifi driver that
> corresponds to a particular SDIO Wifi device that is present in the
> Mirabox. But not on other boards.
> 

Okey, I'll add everything needed to access and test the SPI flash,
including MTD_CHAR.

Thanks,

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
