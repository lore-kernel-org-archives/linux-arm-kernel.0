From: robh@kernel.org (Rob Herring)
Date: Wed, 31 May 2017 11:27:58 -0500
Subject: [PATCHv4 1/2] Documentation: dt: Add TI SCI clock driver
In-Reply-To: <1495458113-7366-2-git-send-email-t-kristo@ti.com>
References: <1495458113-7366-1-git-send-email-t-kristo@ti.com>
 <1495458113-7366-2-git-send-email-t-kristo@ti.com>
Message-ID: <20170531162758.bhhj32m6zcytc7ez@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 04:01:52PM +0300, Tero Kristo wrote:
> Add a clock implementation, TI SCI clock, that will hook to the common
> clock framework, and allow each clock to be controlled via TI SCI
> protocol.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../devicetree/bindings/clock/ti,sci-clk.txt       | 37 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt

Acked-by: Rob Herring <robh@kernel.org>
