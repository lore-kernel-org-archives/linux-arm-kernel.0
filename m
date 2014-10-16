From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Oct 2014 20:41:11 -0700
Subject: [PATCH 4/4] ARM: rockchip: add pmu-sram sub
In-Reply-To: <1413406225-16366-1-git-send-email-zyw@rock-chips.com>
References: <1413405987-16196-1-git-send-email-zyw@rock-chips.com>
 <1413406225-16366-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=V4LrUxLRoMA4neUdA7Xq+mvQwF9MeMtoJ03t0Gjm+R1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Wed, Oct 15, 2014 at 1:50 PM,  <zyw@rock-chips.com> wrote:
> From: Chris Zhong <zyw@rock-chips.com>
>
> The pmu-sram is used to store resume code, suspend/resume need get the
> address of it. Therefore add a node and documentation for it.

This patch just adds bindings, not a node.

>
> Signed-off-by: Tony Xie <xxx@rock-chips.com>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>
> ---
>
>  .../devicetree/bindings/arm/rockchip/pmu-sram.txt  |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt

Title of this patch should probably mention bindings somewhere.  Also
bindings should be patch #3 and the adding to the DTS patch #4.
