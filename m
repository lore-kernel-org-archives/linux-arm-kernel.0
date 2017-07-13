From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Jul 2017 02:12:59 +0200
Subject: [PATCH v2 6/6] ARM: dts: rockchip: add gpio power-key for
 rk3229-evb
In-Reply-To: <1499243590-21772-1-git-send-email-frank.wang@rock-chips.com>
References: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
 <1499243590-21772-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <7144717.vRW3nTzYi1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 5. Juli 2017, 16:33:10 CEST schrieb Frank Wang:
> This patch adds gpio power-key support for rk3229-evb board.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

applied for 4.14 with the following changes:
- replaced keycode with KEY_POWER
- and included dt-bindings/input/input.h
- dropped address and size cells


Heiko
