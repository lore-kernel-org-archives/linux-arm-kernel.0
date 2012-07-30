From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Jul 2012 17:39:11 +0200
Subject: [PATCH 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <20120730153911.GK18016@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:15:56PM +0100, Ian Molton wrote:
> This patch adds basic device tree support to the mv643xx ethernet driver.
> 
> It should be enough for most current users of the device, and should allow
> a fairly painless migration once proper support for clk devices is available
> to those platforms.
> 
> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c |  111 ++++++++++++++++++++++++----
>  1 file changed, 97 insertions(+), 14 deletions(-)

Hi Ian

Please document the DT binding in Documentation/devicetree/binding/....

Also, this should also be CC: to the netdev mailing. I got into
trouble for not doing this and breaking the PPC build :-(

	Andrew
