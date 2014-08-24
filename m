From: rgb@redhat.com (Richard Guy Briggs)
Date: Sun, 24 Aug 2014 16:51:28 -0400
Subject: arm64 audit build failures in -next
In-Reply-To: <20140823155043.GM24407@sirena.org.uk>
References: <E1XLCyO-0007E5-P1@cassiel.sirena.org.uk>
 <20140823155043.GM24407@sirena.org.uk>
Message-ID: <20140824205128.GJ9003@madcap2.tricolour.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/23, Mark Brown wrote:
> On Sat, Aug 23, 2014 at 04:11:20PM +0100, Build bot for Mark Brown wrote:
> > 	arm64-allmodconfig
> > ../arch/arm64/kernel/ptrace.c:1120:3: error: too many arguments to function 'audit_syscall_entry'
> 
> This has now been broken in -next for about a month with a fix available
> and since the merge window the arm64 audit support is in mainline so the
> fix can be directly applied without cross tree issues (the audit changes
> didn't get sent during the merge window).  Catalin and Will have also
> indicated that they want to remove the workaround that's in -next
> currently to allow defconfig to build which would make the situation
> even more pressing.
> 
> Do we have any idea when it will be possible to get a fix into -next?

It will be able to get into -next after eparis has reset his tree to
reference v3.16 targetting v3.18-rc1.  That should be in just over a
week's time.


- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
