From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:07:27 -0600
Subject: [PATCH 01/15] firmware: qcom: scm: Add ipq4019 soc compatible
In-Reply-To: <1517202689-14212-2-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180205022530.xf64gqeijicewdla@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 10:41:15AM +0530, Sricharan R wrote:
> Add the compatible for ipq4019.
> This does not need clocks to do scm calls.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
>  drivers/firmware/qcom_scm.c                             | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
