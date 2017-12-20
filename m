From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 15:13:28 -0600
Subject: [PATCH v5 10/15] devicetree: bindings: Document qcom,kpss-gcc
In-Reply-To: <1513698900-10638-11-git-send-email-sricharan@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-11-git-send-email-sricharan@codeaurora.org>
Message-ID: <20171220211328.wbhaxcisz6bzxxql@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 09:24:55PM +0530, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> The ACC and GCC regions present in KPSSv1 contain registers to
> control clocks and power to each Krait CPU and L2. Documenting
> the bindings here.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |  7 +++++
>  .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  | 32 ++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
