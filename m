From: robh@kernel.org (Rob Herring)
Date: Mon, 8 May 2017 11:40:11 -0500
Subject: [PATCH v2 3/5] clk: qcom: ipq8074: Add Global Clock Controller
 support
In-Reply-To: <1493898841-20583-4-git-send-email-varada@codeaurora.org>
References: <1493898841-20583-1-git-send-email-varada@codeaurora.org>
 <1493898841-20583-4-git-send-email-varada@codeaurora.org>
Message-ID: <20170508164010.aoajie2udehhzduz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 05:23:59PM +0530, Varadarajan Narayanan wrote:
> From: Abhishek Sahu <absahu@codeaurora.org>
> 
> This patch adds support for the global clock controller found on
> the IPQ8074 based devices. This includes UART, I2C, SPI etc.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
>  drivers/clk/qcom/Kconfig                           |    9 +
>  drivers/clk/qcom/Makefile                          |    1 +
>  drivers/clk/qcom/gcc-ipq8074.c                     | 1032 ++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-ipq8074.h       |  152 +++

For the binding,

Acked-by: Rob Herring <robh@kernel.org>

>  5 files changed, 1195 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-ipq8074.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq8074.h
