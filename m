From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Jul 2012 09:20:03 +0200
Subject: [PATCH v2 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <1341898587-8462-4-git-send-email-shawn.guo@linaro.org>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
 <1341898587-8462-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <201207100920.03867.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> From: Marek Vasut <marex@denx.de>
> 
[...]

> +	sound {
> +		compatible = "fsl,imx28-evk-sgtl5000",

imx28-evk ? ;-)

> +			     "fsl,mxs-audio-sgtl5000";
> +		model = "imx28-evk-sgtl5000";
> +		saif-controllers = <&saif0 &saif1>;
> +		audio-codec = <&sgtl5000>;
> +	};
> +};

Otherwise, add my Acked-by: Marek Vasut <marex@denx.de> so if it gets broken 
now, the blame falls on my head ;-)

Best regards,
Marek Vasut
