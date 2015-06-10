From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Jun 2015 10:25:36 +0100
Subject: [PATCH 6/6] arm64: dts: juno: describe PMUs separately
In-Reply-To: <20150602104743.GI2175@e106497-lin.cambridge.arm.com>
References: <1432657876-1362-1-git-send-email-mark.rutland@arm.com>
 <1432657876-1362-7-git-send-email-mark.rutland@arm.com>
 <20150602104743.GI2175@e106497-lin.cambridge.arm.com>
Message-ID: <20150610092536.GB1517@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 11:47:43AM +0100, Liviu Dudau wrote:
> On Tue, May 26, 2015 at 05:31:16PM +0100, Mark Rutland wrote:
> > The A57 and A53 PMUs in Juno support different events, so describe them
> > separately.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> Hi Mark,
> 
> Arnd has pulled my patches that add juno-r1.dts to the mix and he is going
> to send a pull request for v4.2. Care to respin this patch to add support
> for Juno R1 as well?

Sure. Is there a branch out there with just the juno DT patch(es) in?

The DT patch only makes sense after the code changes, and those are
currently based on Will's perf/updates branch (atop of v4.1-rc1), which
doesn't have the DT changes.

Mark.
