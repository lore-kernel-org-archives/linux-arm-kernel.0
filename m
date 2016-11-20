From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 20 Nov 2016 18:38:51 +0530
Subject: [PATCH v5 0/2] platform: Add DT support for DA8xx
In-Reply-To: <1479294456-7942-1-git-send-email-abailon@baylibre.com>
References: <1479294456-7942-1-git-send-email-abailon@baylibre.com>
Message-ID: <0186ccb1-c3ad-e720-a316-1cb33d779b8b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 November 2016 04:37 PM, Alexandre Bailon wrote:
> This add and enable the usb otg for da850 and da850-lcdk.
> This series depends on "driver: dd DT support for DA8xx" patch set.

I see that Bin has already applied this.

> If this series is applied before the "usb: musb: da8xx: Fix few issues" patch
> set then the usb driver will always retrun -ENODEV.

And this seems to be applied too. So I am going ahead and applying this
series.

For future, please add some information on which device you are
referring to in the subject line. Reading the subject line for the
cover-letter, there is no way to know what exactly is being worked on here.

Thanks,
Sekhar
