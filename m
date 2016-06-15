From: juri.lelli@arm.com (Juri Lelli)
Date: Wed, 15 Jun 2016 15:22:39 +0100
Subject: [PATCH v5 1/8] Documentation: arm: define DT cpu
 capacity-dmips-mhz bindings
In-Reply-To: <20160615140447.GB2282@sirena.org.uk>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
 <1465985877-18271-2-git-send-email-juri.lelli@arm.com>
 <20160615140447.GB2282@sirena.org.uk>
Message-ID: <20160615142239.GD5981@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/06/16 15:04, Mark Brown wrote:
> On Wed, Jun 15, 2016 at 11:17:50AM +0100, Juri Lelli wrote:
> 
> > +CPU capacities are obtained by running a suitable benchmark. This binding makes
> > +no aspersions on the validity or suitability of any particular benchmark, the
> > +final capacity should, however, be:
> 
> Makes no guarantees.  An aspersion is an insult!
> 

Whoops! :-/

Sure, I'll change that.

> > +CPU capacities are obtained by running the Dhrystone benchmark on each CPU at
> > +max frequency. The obtained DMIPS score is then divided by the frequency (in
> > +MHz) at which the benchmark has been run, so that DMIPS/MHz are obtained.
> > +Such values are then normalized w.r.t. the highest score obtained in the
> > +system.
> 
> Perhaps worth mentioning that caches and so on should be enabled (based
> on previous experience with people doing bringup)?

OK. I'll add something along this line.

Thanks,

- Juri
