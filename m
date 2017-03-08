From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Mar 2017 13:56:19 +0100
Subject: [PATCH] ARM: dts: imx6ul-14x14-evk: Remove unnecessary node
In-Reply-To: <1486502078-550-1-git-send-email-festevam@gmail.com>
References: <1486502078-550-1-git-send-email-festevam@gmail.com>
Message-ID: <20170308125617.GA19934@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 07:14:38PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> imx6ul.dtsi already contains:
> 
> cpu0: cpu at 0 {
> 	....
> 	arm-supply = <&reg_arm>;
> 	soc-supply = <&reg_soc>;
> };
> 
> , so remove the duplication.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
