From: dianders@google.com (Doug Anderson)
Date: Tue, 10 Jan 2017 10:34:41 -0800
Subject: [PATCH v4 2/2] dt-bindings: clk: add rockchip,
 grf property for RK3399
In-Reply-To: <1484028930-20305-3-git-send-email-zhengxing@rock-chips.com>
References: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
 <1484028930-20305-3-git-send-email-zhengxing@rock-chips.com>
Message-ID: <CAD=FV=Wr0bOLaU2LnhXUSk8b7xaJC2+8ihRvx48Az=zy54Agdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 9, 2017 at 10:15 PM, Xing Zheng <zhengxing@rock-chips.com> wrote:
> Add support for rockchip,grf property which is used for GRF muxes
> on RK3399.
>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
>
> Changes in v4:
> - update the decription for rockchip,grf property
>
> Changes in v3: None
> Changes in v2: None
>
>  Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
