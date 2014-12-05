From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 5 Dec 2014 10:26:26 -0500
Subject: [PATCH 4/5] pinctrl: mvebu: a38x: Add UART1 muxing options
In-Reply-To: <1417790698-9792-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1417790698-9792-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20141205152626.GF22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 03:44:57PM +0100, Maxime Ripard wrote:
> The MPP19 and MMP20 pins also have the ability to be muxed to the uart1
> function.
> 
> Add this case to the pinctrl driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
