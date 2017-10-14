From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 Oct 2017 21:14:13 +0200
Subject: [PATCH] arm64: dts: rockchip: enable touchpad button for
 rk3399-gru-kevin
In-Reply-To: <20171009184028.11829-1-kernel@esmil.dk>
References: <20171009184028.11829-1-kernel@esmil.dk>
Message-ID: <6303636.5G9IA0odAe@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 9. Oktober 2017, 20:40:28 CEST schrieb Emil Renner Berthing:
> Adding the linux,gpio-keymap entry also has
> the side-effect of making the driver register
> the touchpad as a touchpad rather than another
> touchscreen.
> 
> The index for BTN_LEFT was found by trial and error.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>

applied for 4.15 with Dmitry's Ack


Thanks
Heiko
