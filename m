From: dianders@chromium.org (Doug Anderson)
Date: Wed, 8 Aug 2018 13:39:43 -0700
Subject: [PATCH] arm64: dts: sdm845: Add dispcc node
In-Reply-To: <20180803222059.146666-1-mka@chromium.org>
References: <20180803222059.146666-1-mka@chromium.org>
Message-ID: <CAD=FV=VwRp4ip_icn5bUWBbE0XatZrmu5m3pyfifm-s8cS0ShA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 3, 2018 at 3:20 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This adds the display clock controller node to sdm845 based on the
> examples in the bindings.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> The dispcc driver and DT bindings landed in the clk-qcom-dispcc-845
> branch of the clk tree.
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Peachy keen.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
