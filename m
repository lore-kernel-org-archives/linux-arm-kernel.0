From: dianders@chromium.org (Doug Anderson)
Date: Mon, 20 Jul 2015 11:10:50 -0700
Subject: [PATCH] phy: rockchip-usb: power down phy when rockchip phy probe
In-Reply-To: <1437118165-20713-1-git-send-email-hl@rock-chips.com>
References: <1437118165-20713-1-git-send-email-hl@rock-chips.com>
Message-ID: <CAD=FV=XsdDSGiFqUgWNs-V80mAqBFRjB_3zyWkq9WNLJ6cnK5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hl,

On Fri, Jul 17, 2015 at 12:29 AM, huang lin <hl@rock-chips.com> wrote:
> rockchip phy are enable when soc reset, to save power consumption,
> we disable it when probe, and enable each phy when it use
>
> Signed-off-by: huang lin <hl@rock-chips.com>
> ---
>  drivers/phy/phy-rockchip-usb.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Looks right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
