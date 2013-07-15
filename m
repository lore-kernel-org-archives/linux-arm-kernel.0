From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 10:48:22 -0600
Subject: [PATCH V2] ARM: tegra: enable palmas device for dalmore
In-Reply-To: <1373441852-27176-1-git-send-email-ldewangan@nvidia.com>
References: <1373441852-27176-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <51E427D6.7090702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2013 01:37 AM, Laxman Dewangan wrote:
> Make the entry of Dalmore Power Management Unit device TPS65913
> in dalmore DTS file. The Palma driver support this device.
> 
> Enable following submodule of the TPS65913:
> - GPIO driver
> - RTC driver.
> - Power regulator driver.

If I apply this, (at least) the SD card no longer works. I assume the
regulator for it is being turned off somehow.
