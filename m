From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 16:19:36 -0600
Subject: [PATCH v8 15/15] dt-bindings: cpufreq: Document
 operating-points-v2-krait-cpu
In-Reply-To: <1519740422-3835-16-git-send-email-sricharan@codeaurora.org>
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
 <1519740422-3835-16-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180305221936.yu2mlcjodlcumedx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 07:37:02PM +0530, Sricharan R wrote:
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
> operating-points-v2-krait-cpu specifies the phandle to nvmem efuse cells
> and the operating-points-v2 table for each opp. The qcom-cpufreq driver
> reads the efuse value from the SoC to provide the required information
> that is used to determine the voltage and current value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  .../devicetree/bindings/cpufreq/krait-cpufreq.txt  | 363 +++++++++++++++++++++
>  1 file changed, 363 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt

Reviewed-by: Rob Herring <robh@kernel.org>
