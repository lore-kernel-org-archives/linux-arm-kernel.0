From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 4 Sep 2015 14:45:29 -0400 (EDT)
Subject: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
In-Reply-To: <55E9DB76.3080904@ti.com>
Message-ID: <Pine.LNX.4.44L0.1509041443360.29995-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Sep 2015, Grygorii Strashko wrote:

> There is one "small" problem with such approach :(
> 
> - It's incompatible with -RT kernel, because PM runtime can't be used
> in atomic context on -RT.

Can you explain this more fully?  Why can't runtime PM be used in 
atomic context in the -rt kernels?

Alan Stern
