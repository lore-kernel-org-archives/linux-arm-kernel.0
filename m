From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 15 Jun 2016 08:24:38 +0200
Subject: [PATCH v2 4/4] ARM: dts: r8a7790: lager: use demuxer for IIC3/I2C3
In-Reply-To: <20160615042943.GC29110@verge.net.au>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
 <1465370066-8450-5-git-send-email-horms+renesas@verge.net.au>
 <20160613143521.GD1603@katana>
 <20160615042943.GC29110@verge.net.au>
Message-ID: <20160615062438.GA1344@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 01:29:43PM +0900, Simon Horman wrote:
> On Mon, Jun 13, 2016 at 04:35:21PM +0200, Wolfram Sang wrote:
> > 
> > >  		i2c9 = "i2cexio1";
> > >  		i2c10 = "i2chdmi";
> > >  		i2c11 = "gpioi2c";
> > > +		i2c12 = "i2cpwr";
> > 
> > To make it easier for users, we should maybe group them?
> > 
> > i2c8+9: additional gpio busses
> > i2c10-13: i2cexioX
> 
> Should we also group gpioi2cX?

That's what I meant with "additional gpio busses" :) I assume we only
need 2 on lager.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/ac7ee1e9/attachment.sig>
