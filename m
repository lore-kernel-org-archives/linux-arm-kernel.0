From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Wed, 27 Aug 2014 04:08:23 +0200
Subject: [PATCH 0/2 v2] Fix Exynos peach USB on kernels with USB Gadget
 support
In-Reply-To: <1409038230-7242-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1409038230-7242-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <53FD3D97.3010002@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 26.08.2014 09:30, schrieb Sjoerd Simons:
> I suspect other boards base using exynos5420/5800 might need the similar fixes
> (Arndale Octa and Samsung SMDK5420) to their dts files, so would be great if
> folks with those board could verify this.

usbdrd_dwc3_1 is indeed required for the Arndale Octa. Not sure about 0.

I tested my attaching a USB 3.0 disk - is there an easier way to tell?

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
