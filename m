From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2018 13:37:55 -0700
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.18
In-Reply-To: <20180515082811.GL29062@mai>
References: <5AF5A94A.4080308@hisilicon.com>
 <20180514201445.6sglddhalvclu36v@localhost>
 <20180515082811.GL29062@mai>
Message-ID: <20180515203755.esjnphfep5ep7wbe@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 10:28:11AM +0200, Daniel Lezcano wrote:
> On Mon, May 14, 2018 at 01:14:45PM -0700, Olof Johansson wrote:
> > Hi Wei,
> > 
> > On Fri, May 11, 2018 at 03:31:38PM +0100, Wei Xu wrote:
> > > Hi Arnd, Hi Olof,
> > > 
> > > Please help to pull the following changes.
> > > 
> > > About the CLOCK_STUB and the MAILBOX consolidate patch,
> > > Jassi and Stephen have acked it.
> > > Could you let me know how to handle this kind case
> > > if it is not OK to be in this pull?
> > 
> > I don't think there's any need to group the Kconfig changes with the defconfig
> > updates here, is there?
> 
> I don't have the patches history, but likely this patch should come together with:
> 
> https://patchwork.kernel.org/patch/10399799/
> https://patchwork.kernel.org/patch/10399801/
> 
> Otherwise the compilation options won't be consistent with what is enabled in
> the DT.

As long as neither side regresses due to the changes, there should be no
problem. Just because a DT node is added in the tree there's no need to
configure the driver. Or am I missing some aspect of it here?


-Olof
