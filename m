From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 02 Aug 2013 19:23:57 +0100
Subject: [ARM ATTEND] Interested in R/M-class (!MMU), automated testing
Message-ID: <51FBF93D.8040707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm keen to attend the ARM Kernel summit this year. I haven't got a 
specific proposal, but I'd really like to talk to people about !MMU, 
R/M-class (which is where I've done most of my work so far) and 
automation of testing on ARM hardware.

I'm pretty new to the kernel and based on the accounts of other hackers, 
getting to the ARM (mini) summits and meeting people in person is a 
great way to get more involved, so if there are places I'd love to come.

Specifically, after the merging of my MPU support for R-class and 
Uwe/Catalin's M-class patches, I'd like to talk about:

- Whether we can make better use of the MPU/actually have real
   kernel/userspace protection even without an MMU, and how not to kill
   performance doing this
- Whether we want to do MPU support for M-class
- How we can get more eyes on the !MMU code in the kernel - is it
   because nobody's got R/M hardware? R/M isn?t interesting to people so
   far? etc
- Ways to do more automated testing of ARM kernels, including hearing
   from other people what they use to build/boot/test/benchmark their
   code (perhaps even get a discussion going about using the diverse
   range of hardware people have around put to use as test-machines).

Thanks,
Jonny
