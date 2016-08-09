From: juri.lelli@arm.com (Juri Lelli)
Date: Tue, 9 Aug 2016 11:08:57 +0100
Subject: [PATCH v6 0/8] CPUs capacity information for heterogeneous systems
In-Reply-To: <20160808164937.GH6879@twins.programming.kicks-ass.net>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <20160808164937.GH6879@twins.programming.kicks-ass.net>
Message-ID: <20160809100857.GB23236@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/08/16 18:49, Peter Zijlstra wrote:
> On Tue, Jul 19, 2016 at 01:40:40PM +0100, Juri Lelli wrote:
> > Patches high level description:
> > 
> >  o 01/08 introduces documentation for the new optional DT binding
> >  o [02-06]/08 add cpu-capacity attribute to TC2, Juno and Juno r2 DTs and
> >    provide parsing of such information at boot time
> >  o [07-08]/08 introduce sysfs attribute
> > 
> 
> So generally ok with me;

Thanks for reviewing.

> there does seem to be an unfortunate
> duplication of code between arm and arm64 but other than that it looks
> fine.
> 

Yes, I know. I'm failing to see how we can cleanly remove that
duplication, though (sysfs interface and callback functions being good
candidates for a common place).

Anyone any ideas?

Best,

- Juri
