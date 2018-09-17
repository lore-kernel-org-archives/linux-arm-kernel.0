From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Sep 2018 01:45:33 -0400
Subject: [PATCH 01/11] Documentation: dts: Update coresight binding
 examples
In-Reply-To: <1536661032-30481-2-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <5b9f3f7e.1c69fb81.ba4c4.0282@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2018 11:17:02 +0100, Suzuki K Poulose wrote:
> While we updated the coresight DT bindings, some of the
> new examples were not updated due to the order in which they
> were merged. Let us update all the missed out ones to the
> new bindings to avoid confusion.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
