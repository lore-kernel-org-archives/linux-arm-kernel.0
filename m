From: dianders@chromium.org (Doug Anderson)
Date: Tue, 16 Dec 2014 13:04:45 -0800
Subject: [PATCH 2/2] clk: rockchip: use the clock ID for usbphy480m_src
In-Reply-To: <1415863357-15680-2-git-send-email-kever.yang@rock-chips.com>
References: <1415863357-15680-1-git-send-email-kever.yang@rock-chips.com>
 <1415863357-15680-2-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=US1eS4jj-uVFpG2hYFQ3W1D-B3D_ysaCrbee8L=dEU-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Wed, Nov 12, 2014 at 11:22 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> Use the clock ID for usbphy480m_src so that we can find
> this clock node in dts.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
>  drivers/clk/rockchip/clk-rk3288.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
