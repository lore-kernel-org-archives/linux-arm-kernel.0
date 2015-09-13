From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 13 Sep 2015 14:23:39 +0200
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <1441229148-12095-1-git-send-email-dianders@chromium.org>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
Message-ID: <1633680.4IzccqHRpx@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 2. September 2015, 14:25:48 schrieb Douglas Anderson:
> The ddc-i2c-bus property was missing from the veyron dtsi file since
> downstream the ddc-i2c-bus was still being specified in rk3288.dtsi and
> nobody noticed when the veyron dtsi was sent upstream.  Add it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I've applied that to a dts-fixes branch for 4.3 with Brian's Tested-by tag.

As discussed this is temporary-only anyway till the internal i2c stuff of the 
dw_hdmi works.


Heiko
