From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Jun 2015 15:11:39 +0100
Subject: [PATCH 6/6] arm64: dts: juno: describe PMUs separately
In-Reply-To: <20150611103144.GH12807@e106497-lin.cambridge.arm.com>
References: <1432657876-1362-1-git-send-email-mark.rutland@arm.com>
 <1432657876-1362-7-git-send-email-mark.rutland@arm.com>
 <20150602104743.GI2175@e106497-lin.cambridge.arm.com>
 <20150610092536.GB1517@leverpostej>
 <20150611103144.GH12807@e106497-lin.cambridge.arm.com>
Message-ID: <20150611141139.GA8848@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 11:31:44AM +0100, Liviu Dudau wrote:
> On Wed, Jun 10, 2015 at 10:25:36AM +0100, Mark Rutland wrote:
> > On Tue, Jun 02, 2015 at 11:47:43AM +0100, Liviu Dudau wrote:
> > > On Tue, May 26, 2015 at 05:31:16PM +0100, Mark Rutland wrote:
> > > > The A57 and A53 PMUs in Juno support different events, so describe them
> > > > separately.
> > > > 
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > 
> > > Hi Mark,
> > > 
> > > Arnd has pulled my patches that add juno-r1.dts to the mix and he is going
> > > to send a pull request for v4.2. Care to respin this patch to add support
> > > for Juno R1 as well?
> > 
> > Sure. Is there a branch out there with just the juno DT patch(es) in?
> 
> Yes, git://linux-arm.org/linux-ld.git for-upstream/juno-dts

Cheers!

> > The DT patch only makes sense after the code changes, and those are
> > currently based on Will's perf/updates branch (atop of v4.1-rc1), which
> > doesn't have the DT changes.
> 
> Not sure I parse what you meant here.

My dts patch alone won't work with a current kernel (though a kernel
with my perf patches will support existing and new DTBs). So my dts
change shouldn't go through before the code change.

I'd like to base the dts patch on a branch with both your existing dts
changes and my perf code changes to ensure that.

Thanks,
Mark.
