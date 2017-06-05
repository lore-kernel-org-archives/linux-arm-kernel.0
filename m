From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Jun 2017 11:55:11 -0500
Subject: [PATCH v3 3/5] clk: qcom: ipq8074: Add Global Clock Controller
 support
In-Reply-To: <1496316482-25468-4-git-send-email-varada@codeaurora.org>
References: <1496316482-25468-1-git-send-email-varada@codeaurora.org>
 <1496316482-25468-4-git-send-email-varada@codeaurora.org>
Message-ID: <20170605165511.quegmmwuvuexudz4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 01, 2017 at 04:58:00PM +0530, Varadarajan Narayanan wrote:
> From: Abhishek Sahu <absahu@codeaurora.org>
> 
> This patch adds support for the global clock controller found on
> the IPQ8074 based devices. This includes UART, I2C, SPI etc.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +

I acked v2. Please add acks when posting new versions.

>  drivers/clk/qcom/Kconfig                           |    9 +
>  drivers/clk/qcom/Makefile                          |    1 +
>  drivers/clk/qcom/gcc-ipq8074.c                     | 1009 ++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-ipq8074.h       |  152 +++
>  5 files changed, 1172 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-ipq8074.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq8074.h
