From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Jul 2010 18:23:33 +0100
Subject: [PATCH 0/2] Fix ptrace software breakpoints
In-Reply-To: <FB3C047B-0B6C-4605-A481-667C7E75B745@ti.com>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
	<FB3C047B-0B6C-4605-A481-667C7E75B745@ti.com>
Message-ID: <000c01cb2830$47f8a590$d7e9f0b0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> fyi, my gdb test (git://github.com/robclark/gdb-test.git) seems to be passing reliable so far (I
> haven't seen it fail once yet) with these patches..  without these patches, it was triggering passing
> the breakpoing 90+% of the time.
> 
> I'll keep you posted if I notice any issues, but so far so good!

Does this mean you haven't seen it fail yet :)? If so, any
chance I could have a tested-by please?

Will
