From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Sep 2012 09:42:59 +0100
Subject: [PATCHv2] ARM: msm: Implement read_current_timer for msm timers
In-Reply-To: <20120904232111.GA7598@codeaurora.org>
References: <1346371222-7450-1-git-send-email-sboyd@codeaurora.org>
 <20120904232111.GA7598@codeaurora.org>
Message-ID: <20120905084259.GA881@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 12:21:11AM +0100, David Brown wrote:
> On Thu, Aug 30, 2012 at 05:00:22PM -0700, Stephen Boyd wrote:
> > Setup the same timer used as the clocksource to be used as the
> > read_current_timer implementation. This allows us to support a
> > stable udelay implementation on MSMs where it's possible for the
> > CPUs to scale speeds independently of one another.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Acked-by: David Brown <davidb@codeaurora.org>
> 
> Will, let me know if you'd prefer that I pull this.

It probably makes sense for you to take Stephen's patch, however I'll merge
my series through Russell separately. If you want it for 3.7, I can ask Arnd
to pull it into arm-soc as well?

Will
