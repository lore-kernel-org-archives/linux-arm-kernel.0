From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Fri, 19 Aug 2016 07:16:46 +0200
Subject: [PATCH v3 1/3] devicetree: Sort vendor prefixes in alphabetical
 order
In-Reply-To: <20160818230237.GA22939@lunn.ch>
References: <54da74da3f60ede0bf8fb789ffee584703e81a29.1471553094.git.ccc94453@vip.cybercity.dk>
 <20160818230237.GA22939@lunn.ch>
Message-ID: <20160819051645.2lcid73kdy2hwdwk@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 01:02:37AM +0200, Andrew Lunn wrote:
> > @@ -54,8 +54,8 @@ chipone		ChipOne
> >  chipspark	ChipSPARK
> >  chrp	Common Hardware Reference Platform
> >  chunghwa	Chunghwa Picture Tubes Ltd.
> > -ciaa	Computadora Industrial Abierta Argentina
> >  cirrus	Cirrus Logic, Inc.
> > +ciaa	Computadora Industrial Abierta Argentina
> 
> ciaa comes after cirrus?

It does with LC_COLLATE=da_DK :-(
I'm sorry about that. I'll post v4 this afternoon.

-- 
Rask Ingemann Lambertsen
Danish law requires addresses in e-mail to be logged and stored for a year
