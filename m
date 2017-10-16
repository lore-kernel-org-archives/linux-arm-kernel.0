From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 16 Oct 2017 02:13:24 +0200
Subject: [PATCH v3] cpufreq: imx6q: Move speed grading check to cpufreq
 driver
In-Reply-To: <CAOMZO5AwB_2Nbky1wA8neU2-2-LDCTCMFOKGQk4jn5O9zuwKpQ@mail.gmail.com>
References: <1506784606-2064-1-git-send-email-festevam@gmail.com>
 <20171013065141.GI8833@dragon>
 <CAOMZO5AwB_2Nbky1wA8neU2-2-LDCTCMFOKGQk4jn5O9zuwKpQ@mail.gmail.com>
Message-ID: <5060748.qBWaaqo0sL@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, October 15, 2017 5:42:19 PM CEST Fabio Estevam wrote:
> Hi Viresh,
> 
> On Fri, Oct 13, 2017 at 3:51 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> 
> >> Looks fine to me.
> >>
> >> @Shawn: Can you please let us know if you are fine with it?
> >
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> 
> Will this one go through your tree?

No, it won't.

It could go in via the PM tree (which covers cpufreq), but I'd prefer
it to go in via arm-soc.

Thanks,
Rafael
