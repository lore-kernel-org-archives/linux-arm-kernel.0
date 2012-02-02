From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 12:10:20 +0000
Subject: [PATCH v2 8/9] ASoC: imx: add dt support for audmux-v2
In-Reply-To: <1328148728-32258-9-git-send-email-richard.zhao@linaro.org>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-9-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120202121020.GD7428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 10:12:07AM +0800, Richard Zhao wrote:

> +Required properties:
> +- compatible : "fsl,imx31-audmux".
> +
> +Example:
> +
> +audmux at 021d8000 {
> +	compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
> +	reg = <0x021d8000 0x4000>;

It's kind of obvious what it is but you should really document the reg
property for completeness.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/e5bf6556/attachment.sig>
