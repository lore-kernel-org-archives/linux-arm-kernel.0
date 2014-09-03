From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Sep 2014 09:13:31 -0600
Subject: [PATCH 1/2] ARM: tegra: add touchpad to Venice2 DT
In-Reply-To: <1409673430-7039-1-git-send-email-swarren@wwwdotorg.org>
References: <1409673430-7039-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5407301B.2050305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2014 09:57 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Venice2 contains an Atmel MXT touchpad. Add an I2C node for it to DT.
> The Linux driver doesn't quite work on this platform yet, but adding
> the DT node causes no issues, and will allow the device to work once
> the driver is fixed.

I've applied patch 1 to Tegra's for-3.18/dt and patch to to Tegra's 
for-3.18/defconfig branch.
