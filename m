From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Jan 2016 14:50:41 +0100
Subject: [PATCH] ARM: dts: rockchip: Assign RK3288 EDP_24M input centrally
In-Reply-To: <1453720766-13086-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1453720766-13086-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <9462615.JqcFZ6IZ4a@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 25. Januar 2016, 12:19:26 schrieb Sjoerd Simons:
> The EDP 24M clock can be fed either by an SoC internal fixed clock or
> from an external IC. Change the default parent to the internal clock in
> the main rk3288 dtsi, to ensure (by default) it gets setup with a
> non-orphaned clock (hardware defaults to the externa clock).
> 
> This prevents potential issues when the clock framework get support for
> deferring on orphaned clocks, while specific boards can always change
> the parent clock if an external input is preferred.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

applied to dts32 for 4.6
