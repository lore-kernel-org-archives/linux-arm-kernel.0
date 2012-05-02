From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 May 2012 15:13:34 +0100
Subject: [PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add
 clkdevs for given struct clk *
In-Reply-To: <20120502135945.GD2194@S2101-09.ap.freescale.net>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0fb69ddb87f9a5e6a6afec2f833c6341e45763c7.1335249846.git.viresh.kumar@st.com>
 <20120426074746.GD24211@n2100.arm.linux.org.uk> <4F992369.2020308@st.com>
 <20120428095222.GP24211@n2100.arm.linux.org.uk>
 <20120428110108.GD20478@pengutronix.de>
 <20120428110635.GQ24211@n2100.arm.linux.org.uk>
 <20120501123149.GE2194@S2101-09.ap.freescale.net>
 <20120502095404.GA24211@n2100.arm.linux.org.uk>
 <20120502135945.GD2194@S2101-09.ap.freescale.net>
Message-ID: <20120502141334.GD3548@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 09:59:48PM +0800, Shawn Guo wrote:
> On Wed, May 02, 2012 at 10:54:04AM +0100, Russell King - ARM Linux wrote:
> > On Tue, May 01, 2012 at 08:31:51PM +0800, Shawn Guo wrote:
> > > > +	for (i = 0; i < num; i++) {
> > > 
> > > With above line changed to:
> > > 
> > > 	for (i = 0; i < num; i++, cl++) {
> > > 
> > > 
> > > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Thanks, fixed that and committed.
> 
> Can you please publish a branch for clkdev patches, so that we can ask
> Arnd to pull it into arm-soc as a dependency of platform clock porting?

Let's wait for it to be in linux-next - and having it go through one
of my nightly build cycles first (which is where the problem with the
last version from Viresh was noticed.)
