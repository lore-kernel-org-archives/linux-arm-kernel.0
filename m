From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 5 Jun 2015 12:07:44 -0700
Subject: [PATCH v6 0/4] Add basic ZTE zx296702 SOC support
In-Reply-To: <20150605023703.GD17189@dragon>
References: <1433388063-13682-1-git-send-email-jun.nie@linaro.org>
 <20150604182739.GH490@codeaurora.org>
 <20150605023703.GD17189@dragon>
Message-ID: <20150605190744.GB648@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05, Shawn Guo wrote:
> Hi Stephen,
> 
> On Thu, Jun 04, 2015 at 11:27:39AM -0700, Stephen Boyd wrote:
> > On 06/04, Jun Nie wrote:
> > > Changes vs v5:
> > >   - Remove redundant code and polish return value in clock driver.
> > > 
> > > Changes vs v4:
> > >   - Fix issues in clock driver that Stephen found.
> > >   - Remove initramfs in defconfig to avoid overriding test config.
> > >   - Drop patches that already merged into ARM next/soc.
> > > 
> > > Jun Nie (4):
> > >   dt-bindings: Add #defines for ZTE ZX296702 clocks
> > >   clk: zx: add clock support to zx296702
> > >   ARM: dts: zx: add an initial zx296702 dts and doc
> > >   ARM: zx: Add basic defconfig support for ZX296702
> > 
> > clk patch looks ok. If this doesn't go into 4.2 please consider
> > sending the clk driver through the clk tree.
> 
> Can you please either take the clk part through your tree for 4.2, or
> give the permission that we send everything through arm-soc tree for
> 4.2?  Otherwise, it will take such a long time to get the series merged,
> i.e. you will take clk part for 4.3 and the dts part which depends on
> clk part can only possibly land on mainline at 4.4, if I understand your
> comment correctly.

I was saying that if this isn't going to be accepted into arm-soc
because it's too close to the next merge window, then we can take
it through the clk tree next time. Looks like Arnd is ready to
take it though and I've already given Reviewed-by so it should be
good to go through arm-soc.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
