From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 01 Mar 2016 11:03:35 +0100
Subject: [RESEND PATCH 8/8] ARM: dts: rockchip: enable the tsadc for
 rk3228 evb
In-Reply-To: <1455521613-27340-9-git-send-email-wxt@rock-chips.com>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
 <1455521613-27340-9-git-send-email-wxt@rock-chips.com>
Message-ID: <2412973.Kxto885cTd@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 15. Februar 2016, 15:33:33 schrieb Caesar Wang:
> This patch enables the tsadc for rk3228 evb board.
> 
> The rk3228 evb board uses the CRU to reset the chip since it hasn't the
> PMIC to connect it, and TSHUT is low active on evb board.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts32 branch for 4.6


Thanks
Heiko
