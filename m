From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 17 Jul 2017 05:28:20 +0300
Subject: [PATCH v2 5/6] ARM: dts: rockchip: enable RGA for rk3288 devices
In-Reply-To: <CAFLEztRwuzkAn_QrgRNv_yrNixuicfr99PEpR2SDyRROqe=b7w@mail.gmail.com>
References: <1500101920-24039-1-git-send-email-jacob-chen@iotwrt.com>
 <2238838.k7NpPUxaC0@avalon>
 <CAFLEztRwuzkAn_QrgRNv_yrNixuicfr99PEpR2SDyRROqe=b7w@mail.gmail.com>
Message-ID: <3257165.sao50mFgxX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

On Sunday 16 Jul 2017 12:23:02 Jacob Chen wrote:
> 2017-07-15 17:16 GMT+08:00 Laurent Pinchart:
> > On Saturday 15 Jul 2017 14:58:39 Jacob Chen wrote:
> >> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
> >> ---
> >> 
> >>  arch/arm/boot/dts/rk3288-evb.dtsi                 | 4 ++++
> >>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 4 ++++
> >>  arch/arm/boot/dts/rk3288-firefly.dtsi             | 4 ++++
> >>  arch/arm/boot/dts/rk3288-miqi.dts                 | 4 ++++
> >>  arch/arm/boot/dts/rk3288-popmetal.dts             | 4 ++++
> >>  arch/arm/boot/dts/rk3288-tinker.dts               | 4 ++++
> > 
> > Some boards are missing from this list (Fennec, Phycore, ...) What
> > criteria have you used to decide on which ones to enable the RGA ? That
> > should be explained in the commit message.
> 
> Ok.
> 
> I just enable the boards i have tested, because i can't make sure it
> won't break the other board because of clocks or power-domains.

Given the clocks and power domains shouldn't be board-specific, would it make 
sense to try and get the change tested on the remaining boards ? You could 
then enable the device in the SoC .dtsi file, which would be much simpler.

> >>  6 files changed, 24 insertions(+)

-- 
Regards,

Laurent Pinchart
