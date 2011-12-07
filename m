From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 7 Dec 2011 22:28:02 +0100
Subject: [PATCH 1/3] PM: Provide an always on power domain governor
In-Reply-To: <20111207123459.GB18715@opensource.wolfsonmicro.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112062239.57001.rjw@sisk.pl>
 <20111207123459.GB18715@opensource.wolfsonmicro.com>
Message-ID: <201112072228.02916.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 07, 2011, Mark Brown wrote:
> On Tue, Dec 06, 2011 at 10:39:56PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, December 06, 2011, Kukjin Kim wrote:
> 
> > > Rafael, please let me know the branch when you create it so that I can merge
> > > it into Samsung tree to avoid other conflicts.
> 
> > I need an ack from Magnus or Paul on the shmobile patch. When I get one, I'll
> > put patches [1/3] and [2/3] (new version) into my linux-next branch and then
> > (after a few days spent in linux-next) to the pm-domains branch.  I'll let you
> > know when that happens.
> 
> Well, I guess you could put patch 1 and 3 in then add 2 if an ack is
> forthcoming for that - there's no direct dependency.

It's been acked already, I'm going to pul all three patches into
linux-pm/linux-next later today.

Thanks,
Rafael
