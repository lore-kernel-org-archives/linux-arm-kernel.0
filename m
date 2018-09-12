From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 12 Sep 2018 12:40:19 +0200
Subject: [PATCH] ARM: dts: at91: sama5d4: add labels to soc dtsi for
 derivative boards
In-Reply-To: <1536327489-22005-1-git-send-email-eugen.hristev@microchip.com>
References: <1536327489-22005-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <20180912104019.GB2760@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2018 16:38:09+0300, Eugen Hristev wrote:
> This adds labels to commonly used device-tree nodes so that derivative
> boards can avoid ahb/apb hierarchy.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> 
> Hello,
> 
> This was already done for SoC sama5d3 and sam9x5, in commit:
> "fc37204432d" ("ARM: dts: at91: add labels to soc dtsi for derivative boards")
> 
> This commit will do basically the same thing for sama5d4 SoC.
> 
> Based on top of at91-next branch of at91.git
> 
> Thanks.
> 
>  arch/arm/boot/dts/sama5d4.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
