From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 28 Jul 2013 15:19:03 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <1416484.XDfk5G56BI@flatron>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1441731.8CGUI1tUxh@flatron> <20130728085650.GA4683@netboy>
 <1416484.XDfk5G56BI@flatron>
Message-ID: <20130728131901.GA8864@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 28, 2013 at 11:12:53AM +0200, Tomasz Figa wrote:

> I'm not really sure what effect on users this has. Maybe you should define 
> "users".

...

> Care to explain this reasoning?

Use Case
~~~~~~~~

User acquires a machine running ARM Linux version 3.x, with u-boot
and dtb in a read only flash partition. The board boots and works just
fine. However, for his application, the user requires a new kernel
feature that appeared in version 3.y where y > x. He compiles the new
kernel, and it also works.

Thanks,
Richard
