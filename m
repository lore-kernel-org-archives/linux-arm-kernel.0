From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Thu, 8 Sep 2011 20:02:11 +0200
Subject: [PATCH 3.1-rc1] ARM: entry: fix wrong parameter used in
	do_thumb_abort
In-Reply-To: <201109071958.47945.jkrzyszt@tis.icnet.pl>
References: <201108241307.21056.jkrzyszt@tis.icnet.pl>
	<20110907114740.GS6619@n2100.arm.linux.org.uk>
	<201109071958.47945.jkrzyszt@tis.icnet.pl>
Message-ID: <201109082002.11635.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Sep 2011 at 19:58:47 Janusz Krzysztofik wrote:
> On Wed, 7 Sep 2011 at 13:47:40 Russell King - ARM Linux wrote:
> > On Wed, Sep 07, 2011 at 01:10:08PM +0200, Janusz Krzysztofik wrote:
> > > Any special requirements as to the process of submitting bug
> > > fixes against arch/arm common bits?
> > 
> > It needs to go into the patch system for merging so that it doesn't
> > get buried and forgotten - as already demonstrated.
> 
> Still not sure: am I suppposed to do something for the patch to go to
> the patch system? Or do you take care of this?

OK, instead of waiting for your answer, I've found an interface to your 
patch system myself and submitted the patch.

Next time, for how long after posting a patch to the linux-arm-kernel 
lists should I wait for comments before I can submit it to the patch 
system even if there are no signs of the patch being reviewed? IOW, can 
I assume you accept a patch if you don't comment it for a certain period 
of time?

Thanks,
Janusz
