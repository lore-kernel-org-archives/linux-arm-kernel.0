From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 11:22:46 -0500
Subject: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
Message-ID: <20180523162246.GA31202@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 07:43:17PM -0700, David Collins wrote:
> Introduce bindings for RPMh regulator devices found on some
> Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
> processor within the SoC to make PMIC regulator requests which
> are aggregated within the RPMh hardware block along with requests
> from other processors in the SoC to determine the final PMIC
> regulator hardware state.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,rpmh-regulator.txt     | 185 +++++++++++++++++++++
>  .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 ++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
>  create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

Reviewed-by: Rob Herring <robh@kernel.org>
