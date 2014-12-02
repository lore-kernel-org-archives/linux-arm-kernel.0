From: dianders@chromium.org (Doug Anderson)
Date: Tue, 2 Dec 2014 09:57:27 -0800
Subject: [PATCH 1/2] ASoC: rockchip-i2s: dt: add an optional property
 "i2s_clk_out"
In-Reply-To: <1417531766-29669-2-git-send-email-jay.xu@rock-chips.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
 <1417531766-29669-2-git-send-email-jay.xu@rock-chips.com>
Message-ID: <CAD=FV=UhV6gmR4dYUJdPB5tTP9abySCWZotZW_X8ZCtV1v8+cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jianqun,

On Tue, Dec 2, 2014 at 6:49 AM, Jianqun Xu <jay.xu@rock-chips.com> wrote:
> Add an property "i2s_clk_out", which enables to output clock to outside
> of rockchip SoCs. Let's make it optional since not each board needs it.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

You forgot to mention that this is a v3 in the subject line and forgot
to mention what changed between v2 and v3 (nothing changed, but you
should say that).

Despite that, this patch looks reasonable to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>
