From: robh@kernel.org (Rob Herring)
Date: Tue, 04 Sep 2018 08:36:47 -0500
Subject: [PATCH 2/6] clk: imx: vf610: Add CRC clock
In-Reply-To: <20180830171539.20008-3-krzk@kernel.org>
References: <20180830171539.20008-1-krzk@kernel.org>
 <20180830171539.20008-3-krzk@kernel.org>
Message-ID: <5b8e8a6f.1c69fb81.8fb5e.93c2@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2018 19:15:35 +0200, Krzysztof Kozlowski wrote:
> Add the clock for CRC block allowing it to be enabled by HW CRC driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clk/imx/clk-vf610.c             | 1 +
>  include/dt-bindings/clock/vf610-clock.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
