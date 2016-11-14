From: robh@kernel.org (Rob Herring)
Date: Mon, 14 Nov 2016 11:18:04 -0600
Subject: [PATCH 1/2] mfd: pm8921: add support to pm8821
In-Reply-To: <1478622577-20699-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1478622577-20699-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20161114171804.qsad624oa3ms6epj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 04:29:36PM +0000, Srinivas Kandagatla wrote:
> This patch adds support to PM8821 PMIC and interrupt support.
> PM8821 is companion device that supplements primary PMIC PM8921 IC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Tested this patch for MPP and IRQ functionality on IFC6410 and SD600 EVAL
> board with mpps PM8821 and PM8921.
> 
>  .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mfd/pm8921-core.c                          | 368 +++++++++++++++++++--
>  2 files changed, 340 insertions(+), 29 deletions(-)
