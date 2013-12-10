From: gpkulkarni@gmail.com (Ganapat Rao P Kulkarni)
Date: Tue, 10 Dec 2013 13:17:55 +0530
Subject: ARM64: Domain Equivalent support in ARMv8
Message-ID: <CAFpQJXXpO7NmtHJoU0uHYQ_BPQqS+qn3ZgZcQkckWDv1ZjBtTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I want to make kernel code ( all sections/blocks mapped to kernel
code) as RO and change to R/W,  when ever hot-patch of kernel code is
required.
Also, R/W access changes should be available/visible to the core which
sets R/W and all other cores continue to have RO access.

This was easily done using Domain feature(by making Kernel Domain as
Manager, using DACR) on ARMv7.
However, on ARMv8, i see there is no domain support(in AARCH64) and
not able to find the alternative optimal way.

please suggest/share, if you have any ideas to do so.

regards,
Ganapat
