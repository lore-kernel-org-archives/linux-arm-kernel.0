From: horms@verge.net.au (Simon Horman)
Date: Wed, 15 Jun 2016 13:12:57 +0900
Subject: [PATCH v2 2/4] ARM: dts: r8a7790: lager: use demuxer for IIC1/I2C1
In-Reply-To: <20160613143304.GC1603@katana>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
 <1465370066-8450-3-git-send-email-horms+renesas@verge.net.au>
 <20160613143304.GC1603@katana>
Message-ID: <20160615041257.GB29110@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 04:33:04PM +0200, Wolfram Sang wrote:
> On Wed, Jun 08, 2016 at 04:14:24PM +0900, Simon Horman wrote:
> > Make it possible to select which I2C1 IP core you want to run on the
> > EXIO-A connector.
> > 
> > This is based on reference work for the I2C0 core of the lager by Wolfram Sang.
> > 
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Given the PFC problem gets solved, why can't you switch to GP1_16 and
> GP1_17 for those?

Thanks, I missed that. I will see about making it so.
