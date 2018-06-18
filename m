From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Jun 2018 09:37:17 -0700
Subject: [PATCH] ARM: dts: BCM5301x: Fix i2c controller interrupt type
In-Reply-To: <20180611225340.12733-1-f.fainelli@gmail.com>
References: <20180611225340.12733-1-f.fainelli@gmail.com>
Message-ID: <20180618163717.27294-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2018 15:53:40 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The i2c controller should be using IRQ_TYPE_LEVEL_HIGH, fix that.
> 
> Fixes: bb097e3e0045 ("ARM: dts: BCM5301X: Add I2C support to the DT")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
