From: kraxel@redhat.com (Gerd Hoffmann)
Date: Thu, 02 Jun 2016 19:12:49 +0200
Subject: [PATCH 01/32] arm64: Add platform selection for BCM2835.
In-Reply-To: <57506351.3060706@broadcom.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-2-git-send-email-kraxel@redhat.com>
 <574F5881.4060008@gmail.com> <1464849936.24775.33.camel@redhat.com>
 <4e72ae37-a018-a17d-6a58-8450db58d1c7@broadcom.com>
 <57506351.3060706@broadcom.com>
Message-ID: <1464887569.24775.123.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> There is no need to add ARCH_BCM though?

There are Makefile(s) with

obj-$(CONFIG_ARCH_BCM)          += bcm/

in drivers/pinctrl for example, maybe more, didn't check the whole tree.

So without ARCH_BCM some drivers are dropped from the build ...

cheers,
  Gerd
