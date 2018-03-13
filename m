From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 13 Mar 2018 01:37:00 +0100
Subject: [PATCH v5 2/4] rtc: at91sam9: Set name of regmap_config
In-Reply-To: <20180312095142.30854-3-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
 <20180312095142.30854-3-jeffy.chen@rock-chips.com>
Message-ID: <20180313003700.GG3795@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2018 at 17:51:40 +0800, Jeffy Chen wrote:
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4:
> Not to use rtc dev to init regmap, the gpbr is not directly related to
> the rtc.
> 
> Changes in v3: None
> 
>  drivers/rtc/rtc-at91sam9.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
