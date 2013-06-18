From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 03:04:58 -0700
Subject: [PATCH-V2] ARM: OMAP3+: am33xx id: Add new am33xx specific
 function to check dev_feature
In-Reply-To: <1368785621-31591-1-git-send-email-hvaibhav@ti.com>
References: <1368785621-31591-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20130618100458.GH5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [130517 03:19]:
> Layout of DEV_FEATURE register (offset = 0x604) is different
> between TI81xx and AM33xx device, so create separate function
> which will check for features available on specific AM33xx SoC
> and set the flags accordingly.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>

Thanks, applying into omap-for-v3.11/soc.

Regards,

Tony
