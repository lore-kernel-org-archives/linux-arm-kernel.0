From: horms@verge.net.au (Simon Horman)
Date: Wed, 15 Jun 2016 13:29:43 +0900
Subject: [PATCH v2 4/4] ARM: dts: r8a7790: lager: use demuxer for IIC3/I2C3
In-Reply-To: <20160613143521.GD1603@katana>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
 <1465370066-8450-5-git-send-email-horms+renesas@verge.net.au>
 <20160613143521.GD1603@katana>
Message-ID: <20160615042943.GC29110@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 04:35:21PM +0200, Wolfram Sang wrote:
> 
> >  		i2c9 = "i2cexio1";
> >  		i2c10 = "i2chdmi";
> >  		i2c11 = "gpioi2c";
> > +		i2c12 = "i2cpwr";
> 
> To make it easier for users, we should maybe group them?
> 
> i2c8+9: additional gpio busses
> i2c10-13: i2cexioX

Should we also group gpioi2cX?
