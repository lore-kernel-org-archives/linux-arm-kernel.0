From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 28 Sep 2018 10:47:03 -0500
Subject: [PATCH] ARM: dts: socfpga: arria10: add aliases for ethernet
In-Reply-To: <20180928121643.18100-1-s.trumtrar@pengutronix.de>
References: <20180928121643.18100-1-s.trumtrar@pengutronix.de>
Message-ID: <6dd30835-b56c-8322-2c1e-e8c09c7bcc4c@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/28/2018 07:16 AM, Steffen Trumtrar wrote:
> The stmmac driver uses the alias id to enumerate multiple ethernet devices.
> Add the aliases for ethernet, so multiple ethernet ports can be enabled
> without errors.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga_arria10.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Applied, thanks!

Dinh
