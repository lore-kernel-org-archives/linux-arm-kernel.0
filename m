From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 20 Feb 2017 15:13:16 +0530
Subject: [PATCH 0/2] ARM: davinci_all_defconfig: enable modules required
 by vpif
In-Reply-To: <1487267920-3952-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487267920-3952-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <bf6aafdd-352c-a74a-a3b9-265e04acdca9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 February 2017 11:28 PM, Bartosz Golaszewski wrote:
> The first patch enables the modules needed for vpif display.
> 
> The second enables IRQ support for the pca953x driver needed for
> correct vpif capture support on the da850-evm board with the UI
> expander.

Applied to v4.12/defconfig

Thanks,
Sekhar
