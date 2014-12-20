From: dwalker@fifo99.com (dwalker at fifo99.com)
Date: Sat, 20 Dec 2014 22:46:07 +0000
Subject: ***UNCHECKED*** Re: [PATCH] arch: arm: mach-msm: smd.c: Remove
 some unused functions
In-Reply-To: <6909946.FWqDZQSxq2@wuerfel>
References: <1417914740-8390-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <CAFo99gbPKw4uHY_QqyZ495O9QLKL69HQyJmQUKNaGQTNqsG-mw@mail.gmail.com>
 <20141218220128.GA10615@fifo99.com> <6909946.FWqDZQSxq2@wuerfel>
Message-ID: <20141220224607.GA4466@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 11:35:04PM +0100, Arnd Bergmann wrote:
> On Thursday 18 December 2014 22:01:28 dwalker at fifo99.com wrote:
> > On Tue, Dec 16, 2014 at 12:20:43AM +0100, Rickard Strandqvist wrote:
> > > Hi
> > > 
> > > My script looks for the same function name, so if they then would be
> > > named exactly the same, they would come up.
> > > 
> > > But I can not even find drivers/staging/dream/   or is this really new code?
> > 
> > Maybe it was deleted already ..
> 
> It's been gone for over four years, after nobody worked on cleaning it up
> for a while before that:
> 
> commit 3414df8ca38b203c8a5ad8efc32d4a3836a0596d
> Author: Greg Kroah-Hartman <gregkh@suse.de>
> Date:   Fri Oct 29 12:42:18 2010 -0700
> 
>     Staging: dream: remove dream driver and arch from tree
>     
>     This code is stalled, with no one working on it anymore, and the main
>     msm code is now going through the proper channels to get merged
>     correctly.
>     
>     So remove it as it contains a number of kernel information leaks and it
>     is doubtful if it even still builds anymore.
>     
>     Acked-by: Pavel Machek <pavel@ucw.cz>
>     Acked-by: Bryan Huntsman <bryanh@codeaurora.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


Yeah, somehow still ended up in my 3.18 tree. Must have been a "git reset".

Daniel
