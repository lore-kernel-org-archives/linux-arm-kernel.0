From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 22 Sep 2015 00:30:37 +0200
Subject: [PATCH v3 00/12] pwm: add support for atomic update
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <5055506.IbQp3pDAJn@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.

I gave this v3 a spin on a rk3288-veyron device with the pwm-regulator 
supplying vdd_logic. Looks really nice and runs fine, so the series

Tested-by: Heiko Stuebner <heiko@sntech.de>
