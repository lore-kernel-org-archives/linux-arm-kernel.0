From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 16:39:56 +0800
Subject: [RFC] ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet
In-Reply-To: <20180131143407.8324-1-aapo@tuxera.com>
References: <20180131143407.8324-1-aapo@tuxera.com>
Message-ID: <20180205083954.GU31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 02:34:07PM +0000, Aapo Vienamo wrote:
> The missing last digit of the CONFIG values is added. Looks like a typo
> of some sort when comparing to the downstream dt. This fixes
> intermittent behavior behaviour of the ethernet controllers.
> 
> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>

Applied, thanks.
