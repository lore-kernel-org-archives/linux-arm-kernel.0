From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 Feb 2016 22:40:51 +0800
Subject: [PATCH v7 3/7] ARM: dts: imx: Add Advantech BA-16 Qseven module
In-Reply-To: <1454109558-22800-4-git-send-email-akshay.bhat@timesys.com>
References: <1454109558-22800-1-git-send-email-akshay.bhat@timesys.com>
 <1454109558-22800-4-git-send-email-akshay.bhat@timesys.com>
Message-ID: <20160203144051.GQ8307@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 06:19:14PM -0500, Akshay Bhat wrote:
> +&ssi1 {
> +	fsl,mode = "i2s-master";

In Documentation/devicetree/bindings/sound/fsl,ssi.txt, I do not see
'i2s-master' as a valid value for fsl,mode property.

Shawn

> +	status = "okay";
> +};
