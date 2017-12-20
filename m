From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 15:11:47 -0600
Subject: [PATCH v5 05/15] devicetree: bindings: Document qcom,hfpll
In-Reply-To: <1513698900-10638-6-git-send-email-sricharan@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <20171220211147.p555i5eest3ycsbc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 09:24:50PM +0530, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Adds bindings document for qcom,hfpll instantiated within
> the Krait processor subsystem as separate register region.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,hfpll.txt       | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt

"dt-bindings: " is the preferred subject prefix. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
