From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Aug 2013 22:52:21 +0800
Subject: [GIT PULL 3/5] ARM: imx: device tree changes for 3.12
In-Reply-To: <87vc2xu7sa.fsf@linaro.org>
References: <1376833688-24542-1-git-send-email-shawn.guo@linaro.org>
 <1376833688-24542-3-git-send-email-shawn.guo@linaro.org>
 <87vc2xu7sa.fsf@linaro.org>
Message-ID: <20130822145219.GJ30533@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 07:20:05AM -0700, Kevin Hilman wrote:
> Shawn Guo <shawn.guo@linaro.org> writes:
> 
> > Olof, Kevin,
> >
> > The pull request depends on the previous one imx-soc-3.12.  Please take
> > care of it.  Thanks.
> 
> It seems it also has a dependency on [GIT PULL 1/5] for the binding
> changes to the weim bus?  (specifically patch "ARM: dts: i.MX27: Add
> WEIM node" uses the updated binding, correct?)

Applying this patch without [GIT PULL 1/5] does not causes any breakage
or regression.  This new support is supposed to start working when
imx/weim and imx/dt branch get merged together.  We generally do not
take such thing as a dependency, right?

> Please try and describe
> all the dependencies.
> 
> Also, since it's based on the previous pull where I asked for some
> changes (dropping DEBUG_LL support) you'll need to respin this one as well.

Yes, I will respin this one as well.

Shawn
