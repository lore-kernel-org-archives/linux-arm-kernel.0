From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jul 2010 17:32:07 +0100
Subject: [PATCH 0/4] ARM: add support for hw-breakpoints [v4]
In-Reply-To: <1278519780-13317-1-git-send-email-will.deacon@arm.com>
References: <1278519780-13317-1-git-send-email-will.deacon@arm.com>
Message-ID: <003d01cb1df1$f1139f70$d33ade50$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> This is version 4 of the patches originally posted at:
> 
> v1.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/009084.html
> v2.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011170.html
> v3.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017680.html
> 
> Changes from v3 include:
> 	- Based on 2.6.35-rc3
> 	- Support for unaligned addresses
> 	- Numerous bug fixes
> 	- Tested with GDB, for which the testsuite passes
> 
> GDB patches have been posted here:
> 
> http://sourceware.org/ml/gdb-patches/2010-07/msg00110.html
> 
> I'd like to get these patches applied now that I'm confident that
> they function correctly, so please give them a go.
> 
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: S. Karthikeyan <informkarthik@gmail.com>
> Cc: Matthew Gretton-Dann <matthew.gretton-dann@arm.com>
> 

I accidentally passed suppress-cc=all to git send-email, so this
is a pointer for the people I meant to CC. If you want to view
the patchset it's archived at:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/019882.html

Sorry about that,

Will
