From: robh@kernel.org (Rob Herring)
Date: Tue, 19 Jan 2016 12:23:17 -0600
Subject: [PATCH v6 1/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <1453171111-21921-2-git-send-email-xuejiancheng@huawei.com>
References: <1453171111-21921-1-git-send-email-xuejiancheng@huawei.com>
 <1453171111-21921-2-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160119182317.GA3681@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 10:38:26AM +0800, Jiancheng Xue wrote:
> The CRG(Clock and Reset Generator) block provides clock
> and reset signals for other modules in hi3519 soc.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> ---
>  .../devicetree/bindings/clock/hi3519-crg.txt       |  46 +++++++

I already acked this. Please add ack's when posting new versions.

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/hisilicon/Kconfig                      |   7 ++
>  drivers/clk/hisilicon/Makefile                     |   2 +
>  drivers/clk/hisilicon/clk-hi3519.c                 | 132 +++++++++++++++++++++
>  drivers/clk/hisilicon/clk.c                        |  23 ++--
>  drivers/clk/hisilicon/clk.h                        |  14 +--
>  drivers/clk/hisilicon/reset.c                      | 130 ++++++++++++++++++++
>  drivers/clk/hisilicon/reset.h                      |  32 +++++
>  include/dt-bindings/clock/hi3519-clock.h           |  40 +++++++
>  9 files changed, 411 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/hi3519-crg.txt
>  create mode 100644 drivers/clk/hisilicon/clk-hi3519.c
>  create mode 100644 drivers/clk/hisilicon/reset.c
>  create mode 100644 drivers/clk/hisilicon/reset.h
>  create mode 100644 include/dt-bindings/clock/hi3519-clock.h
