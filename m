From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 22 Aug 2012 11:35:11 +0000
Subject: [PATCH 4/5] ASoC: Davinci: machine: Add device tree binding
In-Reply-To: <20120817224327.GK18871@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-5-git-send-email-gururaja.hebbar@ti.com>
 <20120817224327.GK18871@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA658C7@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 18, 2012 at 04:13:28, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 06:12:04PM +0530, Hebbar, Gururaja wrote:
> 
> > +- ti,codec-clock : The Codec Clock from the board
> 
> I think this is the clock rate?  Please specify it more specifically.

I will correct it in v2.

> 
> > +"<CODEC DAI Name>",	"<true if evm_aic3x_init is required, else false>",
> > +"<evm ops required, evm_ops or evm_spdif_ops>";
> 
> Please be more specific as to what these actually do - consider the user
> who is reading the bindings with a view to implementing them for their
> board, or writing drivers for another OS.

Will add more detail in V2

> 


Regards, 
Gururaja
