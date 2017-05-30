From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 31 May 2017 01:20:16 +0300
Subject: [PATCH 1/2] ARM: dts: imx6ul-14x14-evk: Add ksz8081 phy properties
In-Reply-To: <46bde649-c9ce-5a87-d4c4-1c1ebc5a8923@gmail.com>
References: <cover.1496164448.git.leonard.crestez@nxp.com>
 <d31aab90fbdecaf4c5f240becb2d0b0efb23f5c3.1496164448.git.leonard.crestez@nxp.com>
 <46bde649-c9ce-5a87-d4c4-1c1ebc5a8923@gmail.com>
Message-ID: <1496182816.19669.18.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-05-30 at 11:10 -0700, Florian Fainelli wrote:
> On 05/30/2017 10:34 AM, Leonard Crestez wrote:
> > Right now mach-imx6ul registers a fixup for the ksz8081 phy. The same
> > register values can be set through the micrel phy driver by using dts
> > properties.
> > 
> > This seems preferable and allows cleanly fixing suspend/resume.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Should you have a Fixes: tag for that? Sounds like something you'd want
> to backport to stable trees as well, no?

I don't know if suspend over nfs ever worked on this board in upstream
so there is no commit that this patch "Fixes: ". It would make sense to
CC stable.
