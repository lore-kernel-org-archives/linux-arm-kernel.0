From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 4 Nov 2016 09:19:40 -0700
Subject: [PATCH net-next 2/2] net: phy: Add Meson GXL Internal PHY driver
In-Reply-To: <1478274683-1503-3-git-send-email-narmstrong@baylibre.com>
References: <1478274683-1503-1-git-send-email-narmstrong@baylibre.com>
 <1478274683-1503-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <fd01eed5-7b5c-1ee6-9de3-ff18156175cc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/04/2016 08:51 AM, Neil Armstrong wrote:
> Add driver for the Internal RMII PHY found in the Amlogic Meson GXL SoCs.
> 
> This PHY seems to only implement some standard registers and need some
> workarounds to provide autoneg values from vendor registers.
> 
> Some magic values are currently used to configure the PHY, and this a
> temporary setup until clarification about these registers names and
> registers fields are provided by Amlogic.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
