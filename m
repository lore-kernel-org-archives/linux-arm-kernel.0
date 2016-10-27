From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Thu, 27 Oct 2016 09:41:08 +0100
Subject: [PATCH 6/9] power_supply: wm97xx_battery: use
 power_supply_get_drvdata
In-Reply-To: <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161027084108.GE28180@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 09:41:44PM +0200, Robert Jarzmik wrote:
> As the power supply framework provides a way to store and retrieve
> private supply data, use it.
> 
> In the process, change the platform data for wm97xx_battery from a
> container of a single struct wm97xx_batt_pdata to the direct point to wm97xx_batt_pdata.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
