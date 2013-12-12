From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Dec 2013 14:20:17 -0700
Subject: [PATCH 1/2] ARM: tegra: enable ams AS3722 drivers
In-Reply-To: <1386855064-10993-1-git-send-email-ldewangan@nvidia.com>
References: <1386855064-10993-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <52AA2891.2020502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 06:31 AM, Laxman Dewangan wrote:
> ams AS3722 is the system power manager module IC for the Tegra124 based
> Venice2 platform. Enable configs for gpio, pincontrol, rtc, regulator
> support from this device.

I've squashed patch 1/2 into Tegra's for-3.14/defconfig branch.

I've applied patch 2/2 to Tegra's for-3.14/dt branch.
