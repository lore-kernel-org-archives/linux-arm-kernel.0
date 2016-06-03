From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 3 Jun 2016 11:04:43 +0200
Subject: [PATCH v2 7/9] ARM: bcm2835: Add devicetree for the Raspberry Pi
 3.
In-Reply-To: <1464934708-24769-8-git-send-email-kraxel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-8-git-send-email-kraxel@redhat.com>
Message-ID: <18208c0b-d33b-49f2-8f7e-5418954c283b@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 03.06.2016 um 08:18 schrieb Gerd Hoffmann:
> From: Eric Anholt <eric@anholt.net>
>
> While this devicetree also works for booting in 32-bit mode, it's
> placed in arm64 since it's a 64-bit CPU (as suggested by Arnd).

i'm currently working on a patch series to fix dtc warnings like

Warning (unit_address_vs_reg): Node /memory has a reg or ranges
property, but no unit name

This a copy of affected parts ( look at memory, soc and local_intc node ).

So how should this be handled?

a) fix the issues here
b) extend my patch series after this patch has been applied

Stefan
