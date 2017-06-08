From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Jun 2017 14:25:49 -0500
Subject: [PATCH v5 1/6] pinctrl: qcom: Add ipq8074 pinctrl driver
In-Reply-To: <1496900641-27755-2-git-send-email-varada@codeaurora.org>
References: <1496900641-27755-1-git-send-email-varada@codeaurora.org>
 <1496900641-27755-2-git-send-email-varada@codeaurora.org>
Message-ID: <20170608192549.g444mzh4brpv2crj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 11:13:56AM +0530, Varadarajan Narayanan wrote:
> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for ipq8074.
> 
> Signed-off-by: Manoharan Vijaya Raghavan <mraghava@codeaurora.org>
> Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
> ---
>  .../bindings/pinctrl/qcom,ipq8074-pinctrl.txt      |  172 ++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/qcom/Kconfig                       |   10 +
>  drivers/pinctrl/qcom/Makefile                      |    1 +
>  drivers/pinctrl/qcom/pinctrl-ipq8074.c             | 1076 ++++++++++++++++++++
>  4 files changed, 1259 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq8074.c
