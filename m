From: horms@verge.net.au (Simon Horman)
Date: Mon, 4 Dec 2017 09:35:15 +0100
Subject: [PATCH v2 0/4] ARM: dts: renesas: Convert to named i2c-gpio
 bindings
In-Reply-To: <20171201110908.u7xjrt7xmlqgigvy@ninjato>
References: <1512046646-15253-1-git-send-email-geert+renesas@glider.be>
 <20171201081850.4tqbnlvxdax7phfs@verge.net.au>
 <20171201110908.u7xjrt7xmlqgigvy@ninjato>
Message-ID: <20171204083515.sdrba5tq5z2qymap@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 12:09:08PM +0100, Wolfram Sang wrote:
> On Fri, Dec 01, 2017 at 09:18:55AM +0100, Simon Horman wrote:
> > On Thu, Nov 30, 2017 at 01:57:22PM +0100, Geert Uytterhoeven wrote:
> > > 	Hi Simon, Magnus,
> > > 
> > > Commits 7d29f509d2cfd807 ("dt-bindings: i2c: i2c-gpio: Add support for
> > > named gpios") and 05c74778858d7d99 ("i2c: gpio: Add support for named
> > > gpios in DT") introduced named i2c-gpio DT bindings, and deprecated the
> > > more error-prone unnamed variant.
> > > 
> > > This patch series switches all Renesas boards to the new bindings, and
> > > adds the missing GPIO_OPEN_DRAIN I/O flags, which were implicitly
> > > assumed before.  The latter gets rid of messages like:
> > > 
> > >     gpio-208 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file
> > >     gpio-91 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file
> > > 
> > > Patch 1 was extracted from series "[PATCH/RFC 0/3] i2c: gpio: Add
> > > support for named gpios in DT", hence the v2.  All other patches are
> > > new.
> > > 
> > > Note that after this series is applied, the i2c-gpio buses are no longer
> > > detected when booting new DTBs on old (v4.14 and older) kernels, which
> > > should not be an issue.  Booting old DTBs on new kernels is not
> > > affected.
> > > 
> > > Thanks for applying!
> > 
> > Thanks, applied.
> 
> Phew, you guys are fast. For the record:
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, I'll see about adding your tag.
