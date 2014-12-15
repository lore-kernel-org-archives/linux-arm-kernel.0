From: dianders@chromium.org (Doug Anderson)
Date: Mon, 15 Dec 2014 10:14:16 -0800
Subject: [PATCH v7 4/5] ARM: dts: rockchip: add rk3288 usb PHY
In-Reply-To: <1418397141-1079-1-git-send-email-lyz@rock-chips.com>
References: <1418396413-27937-1-git-send-email-lyz@rock-chips.com>
 <1418397141-1079-1-git-send-email-lyz@rock-chips.com>
Message-ID: <CAD=FV=U2C0bfG-STz0Bu9iwtzaaDOk-9K773t3VV--XnVb78hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yunzhi,

On Fri, Dec 12, 2014 at 7:12 AM, Yunzhi Li <lyz@rock-chips.com> wrote:
> This patch adds a device_node for RK3288 SoC usb phy. It also
> defines the phy to be used by three usb controllers: usb_host0/1
> and usb_otg.
>
> Signed-off-by: Yunzhi Li <lyz@rock-chips.com>
>
> ---
>
> Changes in v7:
> - Update dtsi for new usb phy driver.
>
> Changes in v6: None
> Changes in v5:
> - reorder the phy dt node to a correct position.
>
> Changes in v4:
> - Add phy subnodes.
>
> Changes in v3: None
>
>  arch/arm/boot/dts/rk3288.dtsi | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

On rk3288-pinky (on a 3.14 tree with backports), I can confirm that
this properly gets us into low power at suspend time.

Tested-by: Doug Anderson <dianders@chromium.org>


This looks reasonable to me:

Reviewed-by: Doug Anderson <dianders@chromium.org>
