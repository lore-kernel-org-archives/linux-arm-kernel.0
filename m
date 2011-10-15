From: sshaiju@mvista.com (shaiju)
Date: Sat, 15 Oct 2011 01:25:22 +0000 (UTC)
Subject: Oops #817 on ARM MPCore with 2.6.22-rc3
References: <46656DE4.2040406@ccrl-nece.de>	<20070605144122.GD26519@flint.arm.linux.org.uk>
	<tnx7iqixxfy.fsf@arm.com> <466690C0.7060500@ccrl-nece.de>
Message-ID: <loom.20111015T032223-30@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Joerg Wagner <wagner <at> ccrl-nece.de> writes:

> 
> > One more patch worth testing is:
> > 
> > http://www.linux-arm.org/git?p=linux-
2.6.git;a=commitdiff_plain;h=3fe656e0dece808ae1de97f98a2e917c46573beb
> 
> That one looks very interesting indeed.
> However I cannot find any information about the mentioned errata.
> Sadly enough the workaround presented here uses privileged access to CP15 
which might fix the kernel but
> userspace programs are left out.
> 
> If someone can put more light into this I would be glad to hear about it.
> At the first glance it seems to add artificial idle cycles to all operations 
based on ldrex/strex
> combination, but why are they coupled to the processor id ? Isn't there a 
chance that a process/threads
> gets moved to another processor when running code in kernel space (when 
running the idle loop), given a
> preemptive kernel.
> 
> Regards !
> 
> Joerg
> 

Hi  wanger,

Did  this  problem  got  solved .  What  was  the  solution .  I  am  getting 
similar  Error  .

regards,
shaiju

> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
> 
> 
