From: dianders@chromium.org (Doug Anderson)
Date: Tue, 11 Aug 2015 15:56:48 -0700
Subject: [PATCH v5 2/2] pinctrl: rockchip: only enable gpio clock when it
 setting
In-Reply-To: <1439287924-6988-2-git-send-email-hl@rock-chips.com>
References: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
 <1439287924-6988-2-git-send-email-hl@rock-chips.com>
Message-ID: <CAD=FV=VpmoiqoNi2pEQpgbC1R6E7_+Noh0vWGE_9UyK8NZHorw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 11, 2015 at 3:12 AM, Lin Huang <hl@rock-chips.com> wrote:
> gpio can keep state even the clock disable, for save power
> consumption, only enable gpio clock when it setting
>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes in v5:
> -rebase patch
>
>  drivers/pinctrl/pinctrl-rockchip.c | 55 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Also in the ChromeOS 3.14 tree (where this patch has been backported):

Tested-by: Douglas Anderson <dianders@chromium.org>
