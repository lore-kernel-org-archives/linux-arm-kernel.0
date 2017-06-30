From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 30 Jun 2017 22:29:19 +0200
Subject: [PATCH v2 0/2] Add usb2 nodes on RK3328 SoCs and enable usb2 on
 RK3328 evb
In-Reply-To: <1497609255-15724-1-git-send-email-william.wu@rock-chips.com>
References: <1497609255-15724-1-git-send-email-william.wu@rock-chips.com>
Message-ID: <5556458.KTz3hiI43L@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 16. Juni 2017, 18:34:13 CEST schrieb William Wu:
> This series adds support for usb2 on RK3328 SoCs.
> Tested on RK3328 evaluation board.
> 
> William Wu (2):
>   arm64: dts: rockchip: add usb2 nodes for RK3328 SoCs
>   arm64: dts: rockchip: enable usb2 for RK3328 evaluation board

applied for 4.14 with the node references in patch2 slightly restructured.
(u2phy subnodes separate via their phandle)


Thanks
Heiko
