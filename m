From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 2 Jun 2016 21:09:06 +0200 (CEST)
Subject: [PATCH 32/32] mmc: bcm2835: Import bcm2835-mmc and switch to it
In-Reply-To: <87oa7j314j.fsf@eliezer.anholt.net>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-33-git-send-email-kraxel@redhat.com>
 <e16936ee-3b0d-3798-72e0-8969c2c1a309@i2se.com>
 <87oa7j314j.fsf@eliezer.anholt.net>
Message-ID: <2100811505.238666.65d5fa25-985a-4a30-86e2-3a7bebb5caaf.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 2. Juni 2016 um 20:18 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Gerd,
> >
> > Am 01.06.2016 um 23:43 schrieb Gerd Hoffmann:
> >> From: Eric Anholt <eric@anholt.net>
> >>
> >> With this we can get wifi (brcmfmac) to probe.  Without it we're stuck
> >> with timeouts from sdio.c when it tries to set the bus width to 4.
> >
> > adding a new MMC driver to fix a wifi issue is really weird.
> >
> > Beside that there are already two MMC drivers (sdhci-bcm2835.c and
> > sdhci-iproc.c) in the Kernel which are compatible to BCM2835. Why should
> > we add two new ones?
> 
> Despite the fact that this is my commit, I don't think it should be
> merged.  We should figure out why sdhci-iproc.c isn't working, instead.

so it doesn't work with sdhci-bcm2835 on RPi 3, too?

I plan to send a patch series to remove sdhci-bcm2835.

Stefan
