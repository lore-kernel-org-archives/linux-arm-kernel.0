From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 1 Jul 2011 13:37:26 +0200
Subject: [PATCH 2/3] Add tps65921 chip
In-Reply-To: <20110701073557.GF23145@atomide.com>
References: <1308066307-415-1-git-send-email-green@linuxhacker.ru>
	<1308066307-415-3-git-send-email-green@linuxhacker.ru>
	<20110701073557.GF23145@atomide.com>
Message-ID: <20110701113726.GJ12106@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, Jul 01, 2011 at 12:35:58AM -0700, Tony Lindgren wrote:
> Samuel,
> 
> * green at linuxhacker.ru <green@linuxhacker.ru> [110614 08:42]:
> > From: Oleg Drokin <green@linuxhacker.ru>
> > 
> > Very similar to TPS65920
> > List of differences: http://www.ti.com/litv/pdf/swcu066b
> > 
> > CC: sameo at linux.intel.com
> > Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> 
> Looks like this one can be merged independently of the rest of the
> Nook patches via your mfd tree. Care to queue this?
I asked Oleg to rebase this patch against my for-next branch as it was not
applying cleanly. But I never got the fixed patch.
I fixed it up now, and it's applied.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
