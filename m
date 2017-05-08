From: robh@kernel.org (Rob Herring)
Date: Mon, 8 May 2017 11:38:05 -0500
Subject: [PATCH v2 1/5] pinctrl: qcom: Add ipq8074 pinctrl driver
In-Reply-To: <1493898841-20583-2-git-send-email-varada@codeaurora.org>
References: <1493898841-20583-1-git-send-email-varada@codeaurora.org>
 <1493898841-20583-2-git-send-email-varada@codeaurora.org>
Message-ID: <20170508163805.wjjvk4nikbfxn4jt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 05:23:57PM +0530, Varadarajan Narayanan wrote:
> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for ipq8074.
> 
> Signed-off-by: Manoharan Vijaya Raghavan <mraghava@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  .../bindings/pinctrl/qcom,ipq8074-pinctrl.txt      |  187 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/qcom/Kconfig                       |   10 +
>  drivers/pinctrl/qcom/Makefile                      |    1 +
>  drivers/pinctrl/qcom/pinctrl-ipq8074.c             | 1217 ++++++++++++++++++++
>  4 files changed, 1415 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq8074.c
