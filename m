From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 17 May 2017 20:26:30 +0200
Subject: [PATCH v2 2/3] arm: dts: rk322x: correct uart2 pinctrl and add
 another sets
In-Reply-To: <1495014746-27621-3-git-send-email-frank.wang@rock-chips.com>
References: <1495014746-27621-1-git-send-email-frank.wang@rock-chips.com>
 <1495014746-27621-3-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1850566.MEFZHgNvCM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. Mai 2017, 17:52:25 CEST schrieb Frank Wang:
> Correct UART2 PINCTRL flag and add another PINCTRL sets for UART2
> in case of confict with SDMMC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

I've split that into 2 patches:
- pull-up fix
- addition of alternative pinctrl
  (also moved the uart21-xfer into the uart2 group directly below the
   uart2-xfer pinctrl)

I've fixed up the subject in both (ARM: dts: rockchip:) and applied
everything for 4.13


Heiko
