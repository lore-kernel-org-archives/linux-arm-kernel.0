From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 17 Oct 2016 13:45:01 -0600
Subject: [PATCH] hwrng: meson: Fix module autoload for OF registration
In-Reply-To: <1476733214-19044-1-git-send-email-javier@osg.samsung.com>
References: <1476733214-19044-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20161017194501.GD8122@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 04:40:14PM -0300, Javier Martinez Canillas wrote:

> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
>  drivers/char/hw_random/meson-rng.c | 1 +
>  drivers/char/tpm/Kconfig           | 2 +-

Looks like this patch should not have tpm in it.

Jason
