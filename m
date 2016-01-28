From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Jan 2016 11:03:28 +0000
Subject: [PATCH] ARM: dts: imx: replace legacy wakeup property with
 'wakeup-source'
In-Reply-To: <1453951773-22507-1-git-send-email-shawnguo@kernel.org>
References: <1453951773-22507-1-git-send-email-shawnguo@kernel.org>
Message-ID: <56A9F580.8000809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/01/16 03:29, Shawn Guo wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
>
> Though the keyboard and other driver will continue to support the legacy
> "gpio-key,wakeup", "linux,wakeup" and "enable-sdio-wakeup" boolean
> property to enable the wakeup source, "wakeup-source" is the new
> standard binding.
>
> This patch replaces all the legacy wakeup properties with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> This is a resend of Sudeep's patch with following updates:
>
>   - Revise patch subject and commit log a bit to cover enable-sdio-wakeup
>   - Rebase it onto v4.5-rc1 and have the following two instances updated
>     > imx6qdl-nitrogen6_max.dtsi:141: gpio-key,wakeup;
>     > imx7d-sbc-imx7.dts:25: enable-sdio-wakeup;
>

Thanks for picking up and rebasing it.

-- 
Regards,
Sudeep
