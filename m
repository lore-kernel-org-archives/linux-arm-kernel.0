From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 18:24:04 -0600
Subject: [PATCH v4 1/2] dt-bindings: clk: meson-g12a: Add G12A EE Clock
 Bindings
In-Reply-To: <1541682912-120480-2-git-send-email-jian.hu@amlogic.com>
References: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
 <1541682912-120480-2-git-send-email-jian.hu@amlogic.com>
Message-ID: <20181113002404.GA31672@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Nov 2018 21:15:10 +0800, Jian Hu wrote:
> Add new clock controller compatible and dt-bingdings headers
> for the Everything-Else domain of the g12a SoC
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,gxbb-clkc.txt           |  1 +
>  include/dt-bindings/clock/g12a-clkc.h              | 93 ++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
