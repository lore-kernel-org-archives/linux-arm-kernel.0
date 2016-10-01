From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 1 Oct 2016 18:09:01 +0530
Subject: [PATCH 5/6] ARM: davinci: enable the LCDC DRM driver in defconfig
In-Reply-To: <1475166715-7857-6-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-6-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <c266b3f9-09c0-bf51-48a4-2b780c0c6ad0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 September 2016 10:01 PM, Bartosz Golaszewski wrote:
> With the device tree changes for tilcdc in place, we can now enable
> the driver by default in the davinci_all defconfig file.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to v4.10/defconfig branch of my tree. Adjusted the subject line
to be consistent with how patches for defconfig are usually headlines.

ARM: davinci_all_defconfig: enable LCDC DRM driver

defconfig updates are last in the pull request I will send up, so the
description will make sense when finally merged.

Thanks,
Sekhar
