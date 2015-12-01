From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 01 Dec 2015 14:39:31 +0100
Subject: [PATCH 1/2] ARM: dts: rockchip: update the thermal management on
 rk3288
In-Reply-To: <2402718.WBE9iyTUZ2@diego>
References: <2402718.WBE9iyTUZ2@diego>
Message-ID: <3663494.cgIFXjvlv9@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 30. November 2015, 14:13:17 schrieb Heiko St?bner:
> From: Caesar Wang <wxt@rock-chips.com>
> 
> In some cases the machine radiating is very poor,sometime the temperature
> is rising very quickly on heavy loading.So we need have more frequent
> polling and better granularity.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>

applied both patches to my dts32 branch for 4.5
