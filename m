From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Feb 2013 11:25:52 -0500
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <20130205171701.4fcb1304@skate>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130205123827.GG20242@lunn.ch>
 <20130205124833.GS14746@titan.lakedaemon.net>
 <20130205142720.GB2481@localhost>
 <20130205153135.GU14746@titan.lakedaemon.net>
 <20130205171701.4fcb1304@skate>
Message-ID: <20130205162552.GX14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 05:17:01PM +0100, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 5 Feb 2013 10:31:35 -0500, Jason Cooper wrote:
> 
> > One thing we've been doing a lot of with mvebu is using it for
> > build-testing.  For that use case, since the bootloader is there, I'd
> > recommend setting it.  This will reduce the likelyhood of nasty build
> > breakages futher down the line as we'll catch them before pushing to
> > arm-soc.
> 
> To me, the defconfig should enable all the options needed for the
> drivers of on-board devices. So we should enable the driver for this
> SPI flash in the mvebu_defconfig.

I agree.

thx,

Jason.
