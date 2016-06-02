From: kraxel@redhat.com (Gerd Hoffmann)
Date: Thu, 02 Jun 2016 22:03:04 +0200
Subject: [PATCH 32/32] mmc: bcm2835: Import bcm2835-mmc and switch to it
In-Reply-To: <2100811505.238666.65d5fa25-985a-4a30-86e2-3a7bebb5caaf.open-xchange@email.1und1.de>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-33-git-send-email-kraxel@redhat.com>
 <e16936ee-3b0d-3798-72e0-8969c2c1a309@i2se.com>
 <87oa7j314j.fsf@eliezer.anholt.net>
 <2100811505.238666.65d5fa25-985a-4a30-86e2-3a7bebb5caaf.open-xchange@email.1und1.de>
Message-ID: <1464897784.24775.126.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

> > Despite the fact that this is my commit, I don't think it should be
> > merged.  We should figure out why sdhci-iproc.c isn't working, instead.
> 
> so it doesn't work with sdhci-bcm2835 on RPi 3, too?

With sdhci-bcm2835 rpi3 wifi doesn't work for me.
I didn't try sdhci-iproc yet.

cheers,
  Gerd
