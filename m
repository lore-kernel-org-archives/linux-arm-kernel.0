From: pankaj.embedded@gmail.com (Pankaj Pandey)
Date: Wed, 23 Jun 2010 21:29:57 +0530
Subject: Unhandled fault: imprecise external abort
Message-ID: <AANLkTimFhC7PZaT9VVwyVH-jp7Ro74w7sSX2Ma1SX7Mn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am working on Freescale MXC series based target board runing  with 2.6.31
kernel. I have written a small test application to test the one of  driver.
In my test application, I am using mmap to map the kernel memory to user
space and  I am trying to read some register values.
My user space mmap function is as such :

 virt_addr = mmap(NULL, 4 * 1024, PROT_READ, MAP_SHARED ,fd, 0);

The mmap returns a specific address in virt_addr.

When I try to read the contents of this address , the kernel throws
following error :

 Unhandled fault: imprecise external abort (0xc06) at 0x00000000

Any pointers on this will great help to resolve this issue.

Thanks and Regards,
Pankaj Pandey
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100623/b0d121e5/attachment.html>
