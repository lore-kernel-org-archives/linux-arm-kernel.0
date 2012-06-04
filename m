From: johnhlinn@gmail.com (John Linn)
Date: Mon, 4 Jun 2012 15:16:31 -0700
Subject: strongly ordered comment on device memory in mmu.c
Message-ID: <CAB9O=CMc7Lk0RCRL539qOGfx0nO6=JZp3gP1gL_HXvBzkxv3Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We see that the following comment appears to be wrong in that the
memory is device memory rather than strongly ordered memory.

??????? [MT_DEVICE] = {?????????? /* Strongly ordered / ARMv6 shared device */

If it's really just a bad comment we'll do a patch, but I was
wondering if there's more to it such that the comment is correct?

Thanks
