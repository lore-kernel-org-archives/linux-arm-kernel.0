From: mwelling@ieee.org (Michael Welling)
Date: Thu, 21 May 2015 16:04:11 -0500
Subject: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
In-Reply-To: <20150521101857.GR21577@sirena.org.uk>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
 <20150521020709.GA14258@deathray>
 <20150521101857.GR21577@sirena.org.uk>
Message-ID: <20150521210411.GA5406@deathray>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 11:18:57AM +0100, Mark Brown wrote:
> On Wed, May 20, 2015 at 09:07:09PM -0500, Michael Welling wrote:
> 
> > My guess is that the set_cs needs to be called even when toggling as GPIO.
> 
> > How should I handle this?
> 
> It shouldn't be part of a set_cs() operation but rather part of the main
> transfer operation.


Okay then this patch should be reverted.

Do you want to revert the patch and apply a new one or should I provide a
patch that reverts the changes and fixes it all in one?

Sorry for this mess.
