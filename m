From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 14 Dec 2015 22:46:32 +0100
Subject: [PATCH 1/2] ARM: dts: modify rk3288 jaq backlight-level
In-Reply-To: <1449493869-32151-1-git-send-email-wxt@rock-chips.com>
References: <1449493869-32151-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1868289.Tn7cSBTFBY@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Montag, 7. Dezember 2015, 21:11:08 schrieb Caesar Wang:
> the panel which jaq use require the pwm duty cycle larger than 3%,
> when the backlight status from power off to power on, otherwise the
> backlight will flush, so we modify the second brightness-level to 8,
> and when the backlight from power off to power on the pwm duty cycle
> will larger than 3%.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

I've merged the two patches and included them in my series for the veyron edp 
devicetree changes [0].


Heiko

[0] https://github.com/mmind/linux-rockchip/commit/45e3abed0a86c7ee5cea0b35492b65890b928175
