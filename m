From: bgat@billgatliff.com (Bill Gatliff)
Date: Tue, 02 Mar 2010 21:25:01 -0600
Subject: board/device file names, and machine names
In-Reply-To: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4B8DD68D.8000807@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Walker wrote:
> I was wondering if you (or the list) had any suggestions for proper
> names to use in these two cases. Under mach-msm we have tons of devices
> that could be added, and it can sometimes be hard to isolate a sane
> name ..
>   

Nobody outside of Google, HTC and/or Qualcomm will know the internal
names for these devices.

The majority of kernel.org developers don't work for Google, HTC and/or
Qualcomm.  The internal names are therefore meaningless to the majority
of kernel.org developers.

Internet searches by the internal platform names will turn up nothing
useful.

I say use the product release names.  But in board-nexusone.c add a
comment that says "this board is also known as: ...".



b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
