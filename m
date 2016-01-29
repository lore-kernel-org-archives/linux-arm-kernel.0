From: kvalo@codeaurora.org (Kalle Valo)
Date: Fri, 29 Jan 2016 09:11:05 +0000 (UTC)
Subject: [v4,1/3] wlcore/wl12xx: spi: add power operation function
In-Reply-To: <1451482533-8624-2-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <20160129091105.61DD16049D@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The power function uses a consumer regulator access to update the WiFi
> enable GPIO value.
> 
> Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
> Tested-By: Sebastian Reichel <sre@kernel.org>
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks, 2 patches applied to wireless-drivers-next.git:

4c1ce07bcf62 wlcore/wl12xx: spi: add power operation function
04654c386145 wlcore/wl12xx: spi: add device tree support

Kalle Valo
