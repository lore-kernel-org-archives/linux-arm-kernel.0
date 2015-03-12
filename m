From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 12 Mar 2015 08:35:33 +0800
Subject: [PATCH] soc/tegra: move soc_device_register call out of arch/arm
In-Reply-To: <20150311162205.GK952@pengutronix.de>
References: <1425868301-22767-1-git-send-email-josephl@nvidia.com>
 <20150311162205.GK952@pengutronix.de>
Message-ID: <5500DF55.3060900@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, sorry for typo. Thanks, Uwe.

On 03/12/2015 12:22 AM, Uwe Kleine-K?nig wrote:
> On Mon, Mar 09, 2015 at 10:31:41AM +0800, Joseph Lo wrote:
>> Expending the usage for both Tegra & Tegra64 SoCs.
> Expanding? Mabe better: Moving this code to drivers/soc/tegra allows the
> aarch64 SoCs to use it, too.
>
> Best regards
> Uwe
>
