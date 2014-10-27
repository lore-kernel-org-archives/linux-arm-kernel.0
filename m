From: dianders@chromium.org (Doug Anderson)
Date: Mon, 27 Oct 2014 10:46:14 -0700
Subject: [PATCH v4 5/6] ARM: rockchip: Add pmu-sram binding
In-Reply-To: <1413933960-25839-1-git-send-email-zyw@rock-chips.com>
References: <1413933461-25602-1-git-send-email-zyw@rock-chips.com>
 <1413933960-25839-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=VNuMc+J_3vhpD6Op4Qz8YW8NVyYrcmHnuehrFx7X2Fow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Tue, Oct 21, 2014 at 4:26 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> The pmu-sram is used to store resume code, suspend/resume need get the
> address of it. Therefore add a binding and documentation for it.
>
> Signed-off-by: Tony Xie <xxx@rock-chips.com>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  .../devicetree/bindings/arm/rockchip/pmu-sram.txt  |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
