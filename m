From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Mar 2018 17:25:06 -0500
Subject: [PATCH v2 4/7] dt-bindings: clock: reset: Add AXG AO Clock and
 Reset Bindings
In-Reply-To: <20180323143816.200573-5-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
 <20180323143816.200573-5-yixun.lan@amlogic.com>
Message-ID: <20180326222506.jkn5i7eyto3li3ws@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 10:38:13PM +0800, Yixun Lan wrote:
> Add dt-bindings headers for the Meson-AXG's AO clock and
> reset controller.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  include/dt-bindings/clock/axg-aoclkc.h | 26 ++++++++++++++++++++++++++
>  include/dt-bindings/reset/axg-aoclkc.h | 20 ++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

Reviewed-by: Rob Herring <robh@kernel.org>
