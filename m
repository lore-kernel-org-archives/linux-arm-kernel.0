From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 06 Aug 2017 15:45:28 +0200
Subject: [PATCH v2 1/5] arm64: dts: rockchip: Add rk3399 vop and
 display-subsystem
In-Reply-To: <1500301019-9960-2-git-send-email-jacob-chen@iotwrt.com>
References: <1500301019-9960-1-git-send-email-jacob-chen@iotwrt.com>
 <1500301019-9960-2-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <3297411.sT6PaoiFec@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 17. Juli 2017, 22:16:55 CEST schrieb Jacob Chen:
> From: Mark Yao <mark.yao@rock-chips.com>
> 
> Add devicetree nodes for rk3399 VOP (Video Output Processors), and the
> top level display-subsystem root node.
> 
> Later patches add endpoints (eDP, HDMI, MIPI, etc) that attach to the
> VOPs' output ports.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>

applied for 4.14 after moving the display-subsystem node between
cpus and pmu nodes (alphabetical sorting)


Thanks
Heiko
