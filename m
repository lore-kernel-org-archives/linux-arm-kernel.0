From: dianders@chromium.org (Doug Anderson)
Date: Mon, 15 Dec 2014 10:15:37 -0800
Subject: [PATCH v7 5/5] ARM: dts: rockchip: Enable usb PHY on rk3288-evb
 board
In-Reply-To: <1418397422-17249-1-git-send-email-lyz@rock-chips.com>
References: <1418396413-27937-1-git-send-email-lyz@rock-chips.com>
 <1418397422-17249-1-git-send-email-lyz@rock-chips.com>
Message-ID: <CAD=FV=V93J81SVnOpA1jciGfs9Bh9En-quda677tKzdt7sQDMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yunzhi,

On Fri, Dec 12, 2014 at 7:17 AM, Yunzhi Li <lyz@rock-chips.com> wrote:
> Enable usb PHY for all usb ports on rk3288-evb.
>
> Signed-off-by: Yunzhi Li <lyz@rock-chips.com>
>
> ---
>
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
>
>  arch/arm/boot/dts/rk3288-evb.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

I have tested a similar change on rk3288-pinky (on a 3.14 tree with
backports).  There I can confirm that this properly gets us into low
power at suspend time.  I have not tested on EVB itself though, so
leaving off my tested tag.

This does look reasonable to me, though:

Reviewed-by: Doug Anderson <dianders@chromium.org>
