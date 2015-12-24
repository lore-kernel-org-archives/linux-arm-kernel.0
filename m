From: scottwood@freescale.com (Scott Wood)
Date: Wed, 23 Dec 2015 23:40:15 -0600
Subject: [PATCH] ARM64: dts: add LS1043a-QDS board support
In-Reply-To: <1450935037-42930-1-git-send-email-Zhiqiang.Hou@freescale.com>
References: <1450935037-42930-1-git-send-email-Zhiqiang.Hou@freescale.com>
Message-ID: <1450935615.18314.125.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-12-24 at 13:30 +0800, Zhiqiang Hou wrote:
> +/dts-v1/;
> +/include/ "fsl-ls1043a.dtsi"
> +
> +/ {
> +	model = "LS1043A QDS Board";
> +

compatible?

-Scott
