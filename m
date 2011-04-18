From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 18 Apr 2011 10:55:49 +0200
Subject: [PATCH] Fixed gpio polarity of gpio USB-phy reset.
In-Reply-To: <1302766303-1157-1-git-send-email-J.Kilb@phytec.de>
References: <1302766303-1157-1-git-send-email-J.Kilb@phytec.de>
Message-ID: <20110418085548.GB8593@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juergen,

On Thu, Apr 14, 2011 at 09:31:43AM +0200, Juergen Kilb wrote:
> With commit 19403165 a main part of ehci-omap.c moved to
> drivers/mfd/omap-usb-host.c created by commit 17cdd29d.
> Due to this reorganisation the polarity used to reset the
> external USB phy changed and USB host doesn't recognize
> any devices.
Patch applied to my for-linus branch, thanks a lot.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
