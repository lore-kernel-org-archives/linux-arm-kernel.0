From: jkosina@suse.cz (Jiri Kosina)
Date: Mon, 23 Nov 2009 10:25:15 +0100 (CET)
Subject: [PATCH TRIVIAL] atmel_lcdfb.c: Fix sinfo->irqbase from %lu to
	%d in dev_info().
In-Reply-To: <4B0A4813.7060305@evidence.eu.com>
References: <1255083621-25147-1-git-send-email-nicolas.ferre@atmel.com>
	<alpine.LSU.2.00.0910091730560.19284@wotan.suse.de>
	<4B0A4813.7060305@evidence.eu.com>
Message-ID: <alpine.LSU.2.00.0911231023140.6953@wotan.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov 2009, Claudio Scordino wrote:

>    may I ask you the current status of this patch ? I noticed that it
> has not been merged, yet.
> 
> Do we have any idea when it will be done ?
> 
> Since it is a trivial fix, I think it should be merged before the
> release of v2.6.32 (i.e., waiting the next merge window does not make
> much sense for such a trivial fix...).

I usually don't send pull requests for trivial queue to Linus more than 
once per release cycle.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
