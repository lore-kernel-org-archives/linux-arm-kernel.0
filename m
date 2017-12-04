From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Dec 2017 15:37:28 -0600
Subject: [PATCH v4 2/4] clk: meson-axg: add clocks dt-bindings required
 header
In-Reply-To: <20171201012452.27086-3-yixun.lan@amlogic.com>
References: <20171201012452.27086-1-yixun.lan@amlogic.com>
 <20171201012452.27086-3-yixun.lan@amlogic.com>
Message-ID: <20171204213728.e6hzl5wubfkx6fmt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 09:24:50AM +0800, Yixun Lan wrote:
> From: Qiufang Dai <qiufang.dai@amlogic.com>
> 
> Add the required header for the clocks ID dt-bindings
> exported from various subsystem in the Meson-AXG SoC.
> 
> Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  include/dt-bindings/clock/axg-clkc.h | 71 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 include/dt-bindings/clock/axg-clkc.h

Acked-by: Rob Herring <robh@kernel.org>                                                                                
