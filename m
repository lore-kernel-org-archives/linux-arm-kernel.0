From: greg@kroah.com (Greg KH)
Date: Mon, 22 Nov 2010 08:29:26 -0800
Subject: [stable] Patch Upstream: oprofile, ARM: Release resources on
	failure
In-Reply-To: <20101122142203.GM5969@erda.amd.com>
References: <201010212105.o9LL57t9019586@hera.kernel.org>
	<20101029205829.GC29104@kroah.com>
	<20101122142203.GM5969@erda.amd.com>
Message-ID: <20101122162926.GA16137@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 03:22:03PM +0100, Robert Richter wrote:
> On 29.10.10 16:58:29, Greg KH wrote:
> > 
> > This patch doesn't apply to the .35 or .36 stable tree
> > If someone wants it applied there, please email the backport
> > to stable at kernel.org
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > > commit: 81771974ae49bf79aab60c42eac7a6d730a9ef2b
> > > From: Robert Richter <robert.richter@amd.com>
> > > Date: Wed, 29 Sep 2010 16:52:25 +0200
> > > Subject: [PATCH] oprofile, ARM: Release resources on failure
> 
> This patch was accidentally marked as stable. There are already fixes
> in .35 and .36:
> 
>  98d943b02f6f1b57787ff1aa6f34d019a407e3ee upstream in .36
>  1b6740a13ca9774810edacafc5e12514092651e2 in .35 stable of 98d943b

Ok, thanks.

greg k-h
