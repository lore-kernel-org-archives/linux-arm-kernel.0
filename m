From: robh@kernel.org (Rob Herring)
Date: Sat, 19 Mar 2016 18:59:05 -0500
Subject: [PATCH] clk: sunxi: Add CSI (camera's Sensors Interface) module
 clock driver for sun[457]i
In-Reply-To: <1458204222-31149-2-git-send-email-yassinjaffer@gmail.com>
References: <1458204222-31149-1-git-send-email-yassinjaffer@gmail.com>
 <1458204222-31149-2-git-send-email-yassinjaffer@gmail.com>
Message-ID: <20160319235905.GA16539@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 07:43:42PM +1100, yassinjaffer at gmail.com wrote:
> From: Yassin Jaffer <yassinjaffer@gmail.com>
> 
> This patch adds a composite clock type consisting of
> a clock gate, mux, configurable dividers, and a reset control.
> 
> Signed-off-by: Yassin Jaffer <yassinjaffer@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   1 +

I wish someone would just add all the sunxi clocks in one pass instead 
of one by one.

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/Makefile                        |   1 +
>  drivers/clk/sunxi/clk-a10-csi.c                   | 188 ++++++++++++++++++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-a10-csi.c
