From: per.strandh@gmail.com (Per Strandh)
Date: Thu, 20 Jun 2013 20:22:43 +0200
Subject: Get machine type in user space
Message-ID: <CABp-a4cUbwXEGPUQBjGRnNR+X91j1qGQigS=KYTZ1fZ2ZGzQtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I work for a company that develops our own arm-based embedded linux
products. (both hardware and software)

My question is about the "machine type" parameter that is passed from
the  bootloader to the kernel.

If the kernel supports more than one "machine type", the the one that
are specified by the bootloader will be choosen.
If the kernel only supports one "machine type" that will *always* be choosen.

Question:
Is it possible from user-space to find out the "machine type" that was
passed from the bootloader?
I know that in /proc/cpuinfo it is possible to see that "name" of the
choosen "machine type", but not if it was the correct one.

Regards

/Per/
