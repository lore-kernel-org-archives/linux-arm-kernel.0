From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 05 Feb 2018 12:10:46 +0100
Subject: [PATCH v2 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180205072438.nxvhlqk54d7firbz@sapphire.tkos.co.il>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-3-l.stach@pengutronix.de>
 <20180205072438.nxvhlqk54d7firbz@sapphire.tkos.co.il>
Message-ID: <1517829046.3175.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

Am Montag, den 05.02.2018, 09:24 +0200 schrieb Baruch Siach:
> Hi Lucas,
> 
> On Thu, Feb 01, 2018 at 07:31:25PM +0100, Lucas Stach wrote:
> > This is the evaluation kit board for the i.MX8M. The current level
> > of
> > support yields a working console and is able to boot userspace from
> > SD card or Network.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com> (v1)
> > Tested-by: Tested-by: Baruch Siach <baruch@tkos.co.il> (v1)
> 
> I only tested once.

Hehe, seems I was a little tired after reworking all those patches. ;)

> 
> Tested v2 as well, on top of clk v2 and the pinctrl v2 patches.
> 
> Tested-by: Baruch Siach <baruch@tkos.co.il>

Thanks.

> Would have been nice to have all these series in a single branch
> somewhere.

I've pushed a branch with all the MX8M work to:
https://git.pengutronix.de/git/lst/linux mx8-work

I'll update this branch if I need to do another revision of this
patchset.

Regards,
Lucas
