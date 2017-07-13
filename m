From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Jul 2017 02:04:21 +0200
Subject: [PATCH v2 5/6] ARM: dts: rockchip: enable tsadc for rk3229-evb
In-Reply-To: <1499243544-21726-1-git-send-email-frank.wang@rock-chips.com>
References: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
 <1499243544-21726-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <3724160.ss7Gl1arAF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 5. Juli 2017, 16:32:24 CEST schrieb Frank Wang:
> This patch enables the tsadc for rk3229-evb board.
> 
> The rk3229 evb board uses the CRU to reset the chip since it has not
> the PMIC to connect it, and TSHUT is low active on evb board.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

applied for 4.14
