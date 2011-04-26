From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Apr 2011 17:53:31 +0100
Subject: [RFC PATCH 02/12] ARM: smp_twd: add support for remapped PPI
	interrupts
In-Reply-To: <4DB6F127.8050605@codeaurora.org>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-3-git-send-email-marc.zyngier@arm.com>
	<4DB5A991.90002@codeaurora.org>
	<20110426100536.37b9b2ce@taxman.wild-wind.fr.eu.org>
	<4DB6F127.8050605@codeaurora.org>
Message-ID: <20110426175331.03cb7372@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Apr 2011 09:21:59 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 04/26/2011 02:05 AM, Marc Zyngier wrote:
> > I'll move these changes to the first patch on the next iteration of the
> > patch set.
> >
> 
> Thanks. It mattered to me when I only pulled down the first patch and
> the MSM patch and tested it out and was confused why the timer tick
> wasn't happening. MSM doesn't have the ARM twd.

D'oh! Of course, this is a good reason to move this code to the first
patch.

Thanks,

	M.
-- 
I'm the slime oozin' out from your TV set...
