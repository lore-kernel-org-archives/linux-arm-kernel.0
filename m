From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 31 May 2017 14:52:26 -0700
Subject: [PATCH v2 net 2/2] net: phy: micrel: Restore led_mode and clk_sel
 on resume
In-Reply-To: <1460beebce4ba23722cfb185b0f9f884cca3b9e9.1496224930.git.leonard.crestez@nxp.com>
References: <cover.1496224930.git.leonard.crestez@nxp.com>
 <1460beebce4ba23722cfb185b0f9f884cca3b9e9.1496224930.git.leonard.crestez@nxp.com>
Message-ID: <49f66bd1-80f4-ca41-d2a6-eecb189bdebb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2017 03:29 AM, Leonard Crestez wrote:
> These bits seem to be lost after a suspend/resume cycle so just set them
> again. Do this by splitting the handling of these bits into a function
> that is also called on resume.
> 
> This patch fixes ethernet suspend/resume on imx6ul-14x14-evk boards.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
