From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 14 Dec 2011 17:23:50 +0800
Subject: [RFC V2 0/8] imx5 clock port to Mike's clkv4
Message-ID: <1323854638-3455-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in V2:
 - port to Mike's clkv4 base.
 - move clk-div and clk-mux define macro to common header file
 - add driver/clk/imx to hold imx clock drivers and move imx common clock
   and imx51/53 clock to the folder

[RFC V2 1/8] clk: pass parent rate if recalc_rate is NULL
[RFC V2 2/8] clk: Add support for simple dividers
[RFC V2 3/8] clk: Add support for a generic clock multiplexer
[RFC V2 4/8] ARM i.MX: Add generic support for pllv2
[RFC V2 5/8] ARM i.MX: clk: add generic support of gate2b
[RFC V2 6/8] ARM i.MX: prepare common clk support
[RFC V2 7/8] ARM i.MX51/53: reimplement clock support
[RFC V2 8/8] clk/imx: move imx51/imx53 clock to driver/clk/imx

Thanks
Richard
