From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 9 Oct 2013 09:23:56 -0400
Subject: [PATCH v2] ARM: Dove: fix bad properties of the si5351 clkout2
 used by Cubox audio
In-Reply-To: <20131008202027.6d9f0bd2@armhf>
References: <20131008202027.6d9f0bd2@armhf>
Message-ID: <20131009132356.GB5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 08:20:27PM +0200, Jean-Francois Moine wrote:
> As defined in the DT, clkout2 is not allowed to change the pll inside
> si5351.
> 
> This patch extends the properties of clkout2 so that it works as the
> external clock of the audio device in the Cubox.
> 
> Also, as the second si5351 clock is not used in the Cubox, its
> definition is removed.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> v2:
> - remove clkout1 which is not used in the Cubox (Sebastian Hesselbarth)
> ---
>  arch/arm/boot/dts/dove-cubox.dts | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Applied to mvebu/dt with Sebastian's Ack.

thx,

Jason.
