From: viresh.linux@gmail.com (viresh kumar)
Date: Tue, 23 Feb 2010 12:06:45 +0530
Subject: QUERY: Inclusion of header files in kernel header files.
Message-ID: <22dbbef21002222236j2eaaf36cjd3720e2573d25a70@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have been through many kernel header files and have found that kernel
header
files at many places don't include other header files which they have
dependency upon.

For example:
<linux/amba/bus.h> uses struct device and struct resource and it doesn't
include <linux/device.h> and <linux/resource.h> header files.

Now, whenever i try to include bus.h, i have to include device.h and
resource.h.

Is this correct approach?

Again, if i include device.h and resource.h, they must be included before
bus.h.
Now this will disturb the alphabetical ordering of including header files
sometimes. (not in this example)

Any idea behind this philosophy.


regards,
viresh kumar
ST Microelectronics
India.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100223/8f5cac70/attachment.htm>
