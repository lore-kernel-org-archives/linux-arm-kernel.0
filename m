From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 Oct 2012 10:39:42 +0200
Subject: [PATCH] arm: mvebu: update defconfig with 3.7 changes
In-Reply-To: <1350980269-6587-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1350980269-6587-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5087A94E.4000706@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 10:17 AM, Thomas Petazzoni wrote:
> The split of 370 and XP into two Kconfig options and the multiplatform
> kernel support has changed a few Kconfig symbols, so let's update the
> mvebu_defconfig file with the latest changes.

Indeed this patch fixes the mvebu_defconfig which was broken.
But as now mvebu is part of multi_v7_defconfig, shouldn't we just
removed mvebu_defconfig ?

If we to keep it, then you can add my Acked-by.

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> ---
> As this is a simple defconfig update against 3.7 changes, it should
> most likely go into 3.7.
> ---


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
