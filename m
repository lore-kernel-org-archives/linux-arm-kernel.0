From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2016 15:42:23 +0530
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: enable the mstpri and
 ddrctl drivers
In-Reply-To: <1479144724-14231-3-git-send-email-bgolaszewski@baylibre.com>
References: <1479144724-14231-1-git-send-email-bgolaszewski@baylibre.com>
 <1479144724-14231-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <cbcc1774-3590-7fd7-1414-4560b7996891@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 November 2016 11:02 PM, Bartosz Golaszewski wrote:
> With the da8xx memory controller and master peripheral priority
> drivers merged and corresponding device tree changes in place we can
> now enable appropriate options by default.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to v4.10/defconfig

Thanks,
Sekhar
