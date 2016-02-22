From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 10:11:29 -0800
Subject: [PATCH 0/3] ARM: omap2plus_defconfig: Enable OMAP3 ISP and
 dependencies
In-Reply-To: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
References: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20160222181128.GM13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier@osg.samsung.com> [160208 09:54]:
> Hello,
> 
> This small series enables all the Kconfig symbols needed to test the
> OMAP3 ISP on the IGEPv2 board. I've enabled as much as possible as a
> module and only as built-in the options that are boolean.

Looks good to me thanks, applying into omap-for-v4.6/defconfig.

Tony
