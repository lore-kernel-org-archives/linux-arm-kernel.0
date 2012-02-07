From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Feb 2012 11:10:49 +0100
Subject: [PATCH 4/6 V2] of/mtd/nand: add generic bindings and helpers
In-Reply-To: <201202071045.30128.sr@denx.de>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
 <201202061720.24996.sr@denx.de>
 <20120207041606.GD15647@game.jcrosoft.org>
 <201202071045.30128.sr@denx.de>
Message-ID: <20120207101049.GE15647@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:45 Tue 07 Feb     , Stefan Roese wrote:
> On Tuesday 07 February 2012 05:16:06 Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > - nand-on-flash-bbt: boolean to enable on flash bbt option if not
> > > > present false
> > > 
> > > Why not use an "empty" type (without argument) for nand-on-flash-bbt
> > > then?
> > 
> > I want to be able to disable it
> 
> Then just don't add this property.
except if it's it done via include a cpu module enable it but the motherboard
dts want to disable it
>  
> > I send a patch to add a helper to manage boolean
> > 
> > this will allow to disable a boolean
> > 
> >     is-ok;          => true
> >     is-ok = <1>;    => true
> >     is-ok = <0>;    => false


Best Regrds,
J.
