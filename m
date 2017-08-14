From: horms@verge.net.au (Simon Horman)
Date: Mon, 14 Aug 2017 07:38:51 +0200
Subject: [PATCH  1/2] ARM: dts: iwg20d-q7: Add RTC support
In-Reply-To: <20170809090230.GM2705@verge.net.au>
References: <1502197465-61546-1-git-send-email-biju.das@bp.renesas.com>
 <1502197465-61546-2-git-send-email-biju.das@bp.renesas.com>
 <20170809090230.GM2705@verge.net.au>
Message-ID: <20170814053851.GE5654@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 11:02:30AM +0200, Simon Horman wrote:
> On Tue, Aug 08, 2017 at 02:04:24PM +0100, Biju Das wrote:
> > Define the iWave RainboW-G20D-Qseven board dependent part of the
> > RTC device node.
> > 
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> 
> This has a compile-time dependency on
> "[PATCH  2/2] ARM: dts: r8a7743: Add I2C DT support"
> for the i2c2 node, right?

As I have now applied the above dependency I have
also applied this patch for v4.14.
