From: sr@denx.de (Stefan Roese)
Date: Tue, 7 Feb 2012 10:45:30 +0100
Subject: [PATCH 4/6 V2] of/mtd/nand: add generic bindings and helpers
In-Reply-To: <20120207041606.GD15647@game.jcrosoft.org>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
 <201202061720.24996.sr@denx.de> <20120207041606.GD15647@game.jcrosoft.org>
Message-ID: <201202071045.30128.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 February 2012 05:16:06 Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > - nand-on-flash-bbt: boolean to enable on flash bbt option if not
> > > present false
> > 
> > Why not use an "empty" type (without argument) for nand-on-flash-bbt
> > then?
> 
> I want to be able to disable it

Then just don't add this property.
 
> I send a patch to add a helper to manage boolean
> 
> this will allow to disable a boolean
> 
>     is-ok;          => true
>     is-ok = <1>;    => true
>     is-ok = <0>;    => false

Okay, fine with me.

Thanks,
Stefan
