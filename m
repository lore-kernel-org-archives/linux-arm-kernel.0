From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Wed, 07 May 2014 23:24:18 +0200
Subject: [PATCH] ARM: zImage: Allow DTB to override broken ATAG_MEM
In-Reply-To: <CAJAp7OiVrz+epys3Ko79GmMr6ahv8ii8XphVHE77NSM+wK2mOA@mail.gmail.com>
References: <1399439776-18535-1-git-send-email-bjorn.andersson@sonymobile.com>	<20140507080650.GA28564@pengutronix.de>
 <CAJAp7OiVrz+epys3Ko79GmMr6ahv8ii8XphVHE77NSM+wK2mOA@mail.gmail.com>
Message-ID: <536AA482.8040506@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.05.2014 17:29, schrieb Bjorn Andersson:
> My problem is that the boot loader on every shipped Qualcomm MSM8x60, MSM8960
> and APQ8064 based device passes ATAG_MEM with the incorrect start address. There
> is no way to update the boot loader for these.

Chaining bootloaders comes to mind. This is being done on the Exynos5
based Chromebooks, for instance.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
