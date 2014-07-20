From: horms@verge.net.au (Simon Horman)
Date: Sun, 20 Jul 2014 22:35:57 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Boards Cleanups Updates for v3.17
In-Reply-To: <20140719185548.GC4265@quad.lixom.net>
References: <cover.1405641497.git.horms+renesas@verge.net.au>
 <20140719185548.GC4265@quad.lixom.net>
Message-ID: <20140720133549.GA31336@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 19, 2014 at 11:55:48AM -0700, Olof Johansson wrote:
> On Fri, Jul 18, 2014 at 08:59:25AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC Boards Cleanups updates for v3.17.
> > 
> > This pull request is based on a merge of:
> > 
> > * "Fourth Round of Renesas ARM Based SoC Defconfig Updates for v3.17",
> >   tagged as renesas-defconfig4-for-v3.17,
> >   which I have sent a pull request for.
> > 
> >   The reason for this dependency is to avoid attempts to use
> >   genmai_defconfig after the board code it relies on has been removed.
> 
> I'd prefer not to add this dependency. It's not a big deal to have a defconfig
> that won't build momentarily, it doesn't cause any real harm and I'd rather
> avoid keeping this merge/dependency. Can you respin this?

Thanks for the clarification, I'll respin this as you suggest.

> > * "Renesas ARM Based SoC DT Timers Updates for v3.17",
> >   tagged as renesas-dt-timers-for-v3.17,
> >   which I have sent a pull request for.
> 
> Hmm. You're doing cleanups on top of new development instead of the other way
> around. Try to avoid that in future releases if you can.

This relates to the order that the code was developed,
although I agree it is not ideal with the benifit of 20/20 hind-sight.
