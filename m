From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 20 Mar 2012 21:45:49 -0400 (EDT)
Subject: [PATCH v8 0/8] Consolidate cpuidle functionality
In-Reply-To: <87wr6evmnn.fsf@ti.com>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <87wr6evmnn.fsf@ti.com>
Message-ID: <alpine.LFD.2.02.1203202138130.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Mar 2012, Kevin Hilman wrote:

> Looks like you never heard from anyone actively working on at91,
> shmobile, kirwood or davinci.
> 
> I'm not sure we should merge those platform-specific changes without an
> ack from those platform maintainers.

Depends.  There is a limit to how long you may be willing to wait after 
people.  Sometimes the only way to make progress is to merge the thing 
and hope that someone who cares will test the stuff during the ~2 months 
-rc period and provide any fix then.  And if that doesn't happen during 
that time then either the code is just right and no one noticed the 
change, or no one cares anymore.

IMHO, Rob posted those patches many times now for quite a while (many 
months) already.  So I'd suggest simply pushing that stuff into mainline 
as is.


Nicolas
