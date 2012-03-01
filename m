From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 1 Mar 2012 12:14:37 -0800
Subject: [PATCH 7/8] ARM: tegra: export usb phy symbols
In-Reply-To: <1330630010-11241-8-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-8-git-send-email-alan@signal11.us>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861731@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Ott wrote at Thursday, March 01, 2012 12:27 PM:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ehci driver can be a module, so the functions provided
> by the tegra platform code used by ehci-tegra need to
> be exported.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I think this one need to add:

#include <linux/export.h>

In the relevant place.

-- 
nvpublic
