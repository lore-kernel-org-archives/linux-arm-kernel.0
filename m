From: horms@verge.net.au (Simon Horman)
Date: Fri, 14 Sep 2018 15:36:01 +0200
Subject: [PATCH v2] ARM: dts: r9a06g032: Correct UART and add all other
 UARTs
In-Reply-To: <20180912092035.lhzlebd6rh72yjgj@verge.net.au>
References: <20180910160254.3882-1-phil.edworthy@renesas.com>
 <20180912092035.lhzlebd6rh72yjgj@verge.net.au>
Message-ID: <20180914133600.nhbgbmxiafc65abw@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 11:20:39AM +0200, Simon Horman wrote:
> On Mon, Sep 10, 2018 at 05:02:54PM +0100, Phil Edworthy wrote:
> > - UART0 was missing the bus clock ("apb_pclk").
> > - Now that the relevant rzn1 bindings have been added, replace the Synopsys
> >   compat string with the rzn1 strings.
> 
> Perhaps: Use recently accepted r9a06g032 and rzn1 compat strings.
> 
> > - Add all the other UARTs.
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> The above notwithstanding this looks good to me but I will wait to see if
> there are other reviews before applying.
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks again, I have applied this for v4.20 with the changelog
update above.
