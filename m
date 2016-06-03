From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 03 Jun 2016 12:39:15 +0200
Subject: [PATCH v2 7/9] ARM: bcm2835: Add devicetree for the Raspberry
 Pi 3.
In-Reply-To: <3885625.kWfxlR3OJi@wuerfel>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <5490184.9quKRk1Imx@wuerfel> <1464943546.24775.131.camel@redhat.com>
 <3885625.kWfxlR3OJi@wuerfel>
Message-ID: <1464950355.24775.143.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

> I tried
> 
> subdir-y += ../../../arm64/boot/dts/broadcom

Hmm, works for me too now, probably had a typo somewhere.

But it works for "make dtbs" only, "make dtbs_install" ignores it.

cheers,
  Gerd
