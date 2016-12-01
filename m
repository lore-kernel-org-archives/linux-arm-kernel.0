From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 1 Dec 2016 19:52:41 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: Enable the da8xx usb otg
In-Reply-To: <1480350654-26284-1-git-send-email-abailon@baylibre.com>
References: <1480350654-26284-1-git-send-email-abailon@baylibre.com>
Message-ID: <0b412617-fdd0-eb69-e69f-f529b169079f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 November 2016 10:00 PM, Alexandre Bailon wrote:
> The musb driver is enabled but the phy and the glue
> for the da8xx are not enabled.
> Enable them.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Applied to v4.10/defconfig

Thanks,
Sekhar
