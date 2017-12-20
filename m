From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 15:14:50 -0600
Subject: [PATCH v5 12/15] devicetree: bindings: Document qcom,krait-cc
In-Reply-To: <1513698900-10638-13-git-send-email-sricharan@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-13-git-send-email-sricharan@codeaurora.org>
Message-ID: <20171220211450.z2v54bfk53ktpfkz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 09:24:57PM +0530, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> The Krait clock controller controls the krait CPU and the L2 clocks
> consisting a primary mux and secondary mux. Add document for that.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,krait-cc.txt    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
