From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 22 Dec 2009 09:12:21 +0200
Subject: [PATCH 2/4] mx25: don't force input on FEC pins
In-Reply-To: <20091221110409.GD15126@pengutronix.de>
References: <cover.1260785451.git.baruch@tkos.co.il>
	<a7c4a6919d5687cefa6ad12fb8bf2b08733823da.1260785451.git.baruch@tkos.co.il>
	<20091221110409.GD15126@pengutronix.de>
Message-ID: <20091222071221.GA5286@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Dec 21, 2009 at 12:04:09PM +0100, Sascha Hauer wrote:
> On Mon, Dec 14, 2009 at 12:19:40PM +0200, Baruch Siach wrote:
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> >  arch/arm/plat-mxc/include/mach/iomux-mx25.h |   20 ++++++++++----------
> >  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> Can you explain why this is needed in the commit message please?

I tested FEC support without this patch and indeed this patch is not 
necessary.

I just whether there is any benefit in setting the SION bit to a non default 
mode.

Anyway, you can just discard this patch.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
