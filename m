From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 05 Feb 2013 17:20:02 +0100
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <20130205171701.4fcb1304@skate>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130205123827.GG20242@lunn.ch>
 <20130205124833.GS14746@titan.lakedaemon.net>
 <20130205142720.GB2481@localhost>
 <20130205153135.GU14746@titan.lakedaemon.net> <20130205171701.4fcb1304@skate>
Message-ID: <51113132.6000500@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 05:17 PM, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 5 Feb 2013 10:31:35 -0500, Jason Cooper wrote:
> 
>> One thing we've been doing a lot of with mvebu is using it for
>> build-testing.  For that use case, since the bootloader is there, I'd
>> recommend setting it.  This will reduce the likelyhood of nasty build
>> breakages futher down the line as we'll catch them before pushing to
>> arm-soc.
> 
> To me, the defconfig should enable all the options needed for the
> drivers of on-board devices. So we should enable the driver for this
> SPI flash in the mvebu_defconfig.
> 

So that means we should enable the drivers for all the devices present
on all the boards?

> Best regards,
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
