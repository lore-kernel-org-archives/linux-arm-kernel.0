From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 31 Jul 2018 23:35:09 +0200 (CEST)
Subject: next/master boot: 171 boots: 6 failed, 162 passed with 3
 offline (next-20180724)
In-Reply-To: <bb89388b-db7e-a59f-6fd1-4e88b602054c@arm.com>
References: <5b5757ee.1c69fb81.411a5.52e2@mx.google.com>
 <20180725161151.GA340@sirena.org.uk> <20180731155246.GG5719@sirena.org.uk>
 <bb89388b-db7e-a59f-6fd1-4e88b602054c@arm.com>
Message-ID: <1380807549.9923.1533072909710@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Robin Murphy <robin.murphy@arm.com> hat am 31. Juli 2018 um 19:00 geschrieben:
> 
> 
> On 31/07/18 16:52, Mark Brown wrote:
> > On Wed, Jul 25, 2018 at 05:11:51PM +0100, Mark Brown wrote:
> >> On Tue, Jul 24, 2018 at 09:46:38AM -0700, kernelci.org bot wrote:
> > 
> >> For a little while now the RPi B has been failing to boot using the
> >> bcm2835 defconfig in -next:
> > 
> > ...
> > 
> >> It's working fine on arm64, whatever's going on appears to be specific
> >> to this config (it's not getting booted with any other 32 bit configs).
> >> Full info and boot logs for one of the boards here:
> > 
> >>     https://kernelci.org/boot/id/5b58416759b514139596baae/
> > 
> >> it looks like it hangs somewhere shortly after or during initializing
> >> MMC so never makes it to the console, the tail of the failing logs looks
> >> like:
> > 
> > This went away for a day or two but it looks like it's back again I'm
> > afraid:
> 
> FWIW, it looks like that blip was due to me completely breaking DMA API 
> functionality for DT devices in next-20180727. Funny that that actually 
> "helped" in this case (unlike all the others...), but it definitely 
> reinforces Stefan's observation.
> 
> Robin.
> 

Sorry, still not much time this week. All i can say that next-20180731 is broken, but dma-mapping/for-next is not.
