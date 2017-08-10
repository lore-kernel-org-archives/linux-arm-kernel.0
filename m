From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 12:07:18 -0500
Subject: [PATCH v3 5/5] phy: rockchip-inno-usb2: add support of usb2-phy
 for rv1108 SoCs
In-Reply-To: <1501747831-13520-1-git-send-email-frank.wang@rock-chips.com>
References: <1501747753-6983-1-git-send-email-frank.wang@rock-chips.com>
 <1501747831-13520-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <20170810170718.vv74gtqdu4oaymo3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 04:10:31PM +0800, Frank Wang wrote:
> This adds support usb2-phy for rv1108 SoCs and amend phy Documentation.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  .../bindings/phy/phy-rockchip-inno-usb2.txt        |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c      | 43 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
