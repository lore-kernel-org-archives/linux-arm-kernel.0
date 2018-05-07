From: robh@kernel.org (Rob Herring)
Date: Mon, 7 May 2018 11:07:37 -0500
Subject: [PATCH v5 10/14] dt-bindings: qcom_spmi: Add support for SAW
 documentation
In-Reply-To: <1525348355-25471-11-git-send-email-ilialin@codeaurora.org>
References: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org>
 <1525348355-25471-11-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180507160737.GA16495@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 02:52:31PM +0300, Ilia Lin wrote:
> Add support for SAW controlled regulators.
> The regulators defined as SAW controlled in the device tree
> will be controlled through special CPU registers instead of direct
> SPMI accesses.
> This is required especially for CPU supply regulators to synchronize
> with clock scaling and for Automatic Voltage Switching.
> Document it.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.txt     | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
