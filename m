From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Dec 2017 14:36:31 -0600
Subject: [PATCH v4 05/12] clk: qcom: Add MSM8960/APQ8064's HFPLLs
In-Reply-To: <1512726150-7204-6-git-send-email-sricharan@codeaurora.org>
References: <1512726150-7204-1-git-send-email-sricharan@codeaurora.org>
 <1512726150-7204-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <20171212203631.kyruwhtpmigkwfat@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 03:12:23PM +0530, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Describe the HFPLLs present on MSM8960 and APQ8064 devices.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-msm8960.c               | 172 +++++++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-msm8960.h |   2 +

For the binding,

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 174 insertions(+)
