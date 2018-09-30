From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 30 Sep 2018 15:33:34 +0800
Subject: [PATCH V3 0/3] Add i.MX6ULZ SoC support
In-Reply-To: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
References: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180930073332.GO26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2018 at 11:32:25AM +0800, Anson Huang wrote:
> This patch set adds i.MX6ULZ SoC support, i.MX6ULZ is a new SoC of
> i.MX6 family, compared to i.MX6ULL, it removes below modules:
> 
>     - UART5/UART6/UART7/UART8;
>     - PWM5/PWM6/PWM7/PWM8;
>     - eCSPI3/eCSPI4;
>     - CAN1/CAN2;
>     - FEC1/FEC2;
>     - I2C3/I2C4;
>     - EPIT2;
>     - LCDIF;
>     - GPT2;
>     - TSC;
> 
> And i.MX6ULZ has same soc_id as i.MX6ULL, but SRC_SBMR2 bit[6] is
> to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and
> 1'b0 means i.MX6ULL. i.MX6ULZ reuse most of i.MX6UL/i.MX6ULL code,
> just add the new CPU type and remove those non-exist modules from dtb.
> 
> Anson Huang (3):
>   ARM: imx: add i.mx6ulz msl support
>   dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
>   ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support

Applied all, thanks.
