From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Jun 2018 09:56:10 -0500
Subject: [PATCH v5 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <af7152133afd7bbf9ad207905ec4e8d5cbe4e718.1527901471.git.collinsd@codeaurora.org>
References: <cover.1527901471.git.collinsd@codeaurora.org>
 <af7152133afd7bbf9ad207905ec4e8d5cbe4e718.1527901471.git.collinsd@codeaurora.org>
Message-ID: <20180604145610.GA8926@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 06:34:05PM -0700, David Collins wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++++++++++++++++++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +++++
>  2 files changed, 196 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
>  create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

Reviewed-by: Rob Herring <robh@kernel.org>
