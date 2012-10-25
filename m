From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 25 Oct 2012 14:41:25 -0600
Subject: [PATCH V2] ARM: dt: tegra: ventana: define pinmux for ddc
In-Reply-To: <1351147951-19706-1-git-send-email-markz@nvidia.com>
References: <1351147951-19706-1-git-send-email-markz@nvidia.com>
Message-ID: <5089A3F5.40005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 12:52 AM, Mark Zhang wrote:
> Tegra 2's I2C2 controller can be routed to either the PTA
> or DDC pin group on Ventana. So:
> - Remove the HDMI function definition of pta pingroup
> - Define child i2c adapters(ddc & pta) for I2C2 controller

Thanks, this looks good now.

I've applied it to Tegra's for-3.8/dt branch for now, although I may
have to shuffle things around (or just rename that branch) depending on
exactly what patches we end up with to enable tegradrm.
