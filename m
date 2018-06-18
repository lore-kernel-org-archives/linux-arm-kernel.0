From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Jun 2018 09:36:59 -0700
Subject: [PATCH 1/3] ARM: dts: NSP: Fix i2c controller interrupt type
In-Reply-To: <20180611224714.7007-2-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com>
 <20180611224714.7007-2-f.fainelli@gmail.com>
Message-ID: <20180618163659.27039-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jun 2018 15:47:12 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The i2c controller should use IRQ_TYPE_LEVEL_HIGH instead of
> IRQ_TYPE_NONE.
> 
> Fixes: 0f9f27a36d09 ("ARM: dts: NSP: Add I2C support to the DT")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
