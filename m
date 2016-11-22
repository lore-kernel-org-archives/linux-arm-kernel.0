From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Nov 2016 20:56:38 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: Enable OHCI as module
In-Reply-To: <20161121170131.30157-1-ahaslam@baylibre.com>
References: <20161121170131.30157-1-ahaslam@baylibre.com>
Message-ID: <6d7316fc-0c76-8166-7d24-845988169d00@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 November 2016 10:31 PM, Axel Haslam wrote:
> Enable the davinci ohci driver as a module for usb
> tested with the omap138-lcdk hawk board.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Applied to v4.10/defconfg after dropping "hawk" from commit description.

Thanks,
Sekhar
