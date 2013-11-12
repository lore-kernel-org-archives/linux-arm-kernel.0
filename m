From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 12 Nov 2013 10:45:34 -0500
Subject: [PATCH 01/12] mtd: nand: davinci: fix driver registration
In-Reply-To: <4F5844B3A985794BA902E12C070812375F8CE2@DNCE04.ent.ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-2-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8CE2@DNCE04.ent.ti.com>
Message-ID: <52824D1E.9080409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 November 2013 11:52 AM, Khoronzhuk, Ivan wrote:
> 
> When kernel is booted using DT, there is no guarantee that Davinci
> NAND device has been created already at the time when driver init
> function is executed. Therefore, platform_driver_probe() can't be used
> because this may result the Davinci NAND driver will never be probed.
> The driver probing has to be made with core mechanism.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
