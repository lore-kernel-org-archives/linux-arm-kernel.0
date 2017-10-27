From: robh@kernel.org (Rob Herring)
Date: Thu, 26 Oct 2017 22:23:11 -0500
Subject: [PATCH v6 2/9] clk: mediatek: Add dt-bindings for MT2712 clocks
In-Reply-To: <1508731840-4231-3-git-send-email-weiyi.lu@mediatek.com>
References: <1508731840-4231-1-git-send-email-weiyi.lu@mediatek.com>
 <1508731840-4231-3-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <20171027032311.2am3x3fbrdxwr5oj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 12:10:33PM +0800, Weiyi Lu wrote:
> Add MT2712 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, pericfg, mcucfg and subsystem clocks.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  include/dt-bindings/clock/mt2712-clk.h | 427 +++++++++++++++++++++++++++++++++
>  1 file changed, 427 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt2712-clk.h

Acked-by: Rob Herring <robh@kernel.org>
