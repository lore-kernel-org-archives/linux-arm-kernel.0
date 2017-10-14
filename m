From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Sat, 14 Oct 2017 10:23:12 +0200
Subject: [PATCH 0/3] Enable CEC on rk3399
In-Reply-To: <20171013225337.5196-1-phh@phh.me>
References: <20171013225337.5196-1-phh@phh.me>
Message-ID: <9833f103-769f-b9b9-05c7-4d75bd7e487c@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2017 12:53 AM, Pierre-Hugues Husson wrote:
> Enable CEC on firefly-rk3399.
> Tested on a TV with cec-ctl --playback; cec-ctl -S
> 
> Pierre-Hugues Husson (3):
>   drm: bridge: synopsys/dw-hdmi: Enable cec clock
>   arm64: dts: rockchip: add the cec clk for dw-mipi-hdmi on rk3399
>   arm64: dts: rockchip: enable cec pin for rk3399 firefly
> 
>  arch/arm64/boot/dts/rockchip/rk3399-firefly.dts |  2 ++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi        |  8 ++++++--
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c       | 16 ++++++++++++++++
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 

Nice! I had a similar dw-hdmi.c patch pending but got around to posting it.

I'll brush off my old rk3288 patches and see if I can get CEC enabled
for my firefly-reload. I was close to getting it work, but I guess
missed the "enable cec pin" change.

Regards,

	Hans
