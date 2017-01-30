From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 30 Jan 2017 22:33:31 +0100 (CET)
Subject: [PATCH 4/4] ARM: dts: bcm283x: switch from &sdhci to &sdhost
In-Reply-To: <1485516989-1072-5-git-send-email-kraxel@redhat.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-5-git-send-email-kraxel@redhat.com>
Message-ID: <706496282.15740.1485812011760@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Gerd Hoffmann <kraxel@redhat.com> hat am 27. Januar 2017 um 12:36 geschrieben:
> 
> 
> This flips the switch from (iproc-driven) sdhci controller to the custom
> sdhost controller.

As long as the SDHOST driver isn't enabled in bcm2835_defconfig we shouldn't do that.

Btw please write down the reason why this should be changed.
