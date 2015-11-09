From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 22:32:01 +0100
Subject: [PATCH] power: bq27xxx_battery: Add I2C module check dependency
 in Kconfig
In-Reply-To: <1447104183-13556-1-git-send-email-afd@ti.com>
References: <1447104183-13556-1-git-send-email-afd@ti.com>
Message-ID: <4760713.cM5ekhZCt2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 November 2015 15:23:03 Andrew F. Davis wrote:
> Check if I2C core has been built as a module when BATTERY_BQ27XXX
> is built-in. If so disable I2C functionality.
> 
> Fixes: 6bd03ce3c12a ("power: bq27xxx_battery: Remove unneeded dependency in Kconfig")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Thanks for the fix!

Acked-by: Arnd Bergmann <arnd@arndb.de>
