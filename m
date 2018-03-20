From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 20 Mar 2018 11:44:50 +0800
Subject: [v2 PATCH 0/2] arm64: dts: Add sdm845 GPU/GMU and SMMU
In-Reply-To: <20180316185152.32020-1-jcrouse@codeaurora.org>
References: <20180316185152.32020-1-jcrouse@codeaurora.org>
Message-ID: <20180320034450.tw4lcw6jv6wktmef@vireshk-mac-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-03-18, 12:51, Jordan Crouse wrote:
> (resend because I forgot to CC everybody on the patches)
> 
> Add DT nodes for the sdm845 GPU/GMU (graphics management unit) and the companion
> arm-smmu-v2 compatible SMMU.
> 
> This builds on the following dependencies -
> https://patchwork.kernel.org/patch/10286369/ - bindings for qcom,level
> https://patchwork.kernel.org/patch/10281599/ - qcom,smmu-v2 bindings
> 
> Please refer to https://patchwork.freedesktop.org/series/37428/ for the driver
> code.
> 
> [v2 - changed qcom,arc-level to qcom,level following discussion with Viresh;
> change gmu phandle to qcom,gmu per Rob]
> 
> Jordan Crouse (2):
>   dt-bindings: Document qcom,adreno-gmu
>   arm64: dts: sdm845: Add gpu and gmu device nodes

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
