From: omycle@gmail.com (Li Haifeng)
Date: Wed, 4 Jul 2012 14:01:25 +0800
Subject: Fwd: before arm Linux 2.6.38, how to protect the kernel memory from
 accessing in user space?
In-Reply-To: <CAFNq8R6cxPgADH=oOxkyenx4ADEPs+dapzj5mDrVftya3yBj3A@mail.gmail.com>
References: <CAFNq8R6cxPgADH=oOxkyenx4ADEPs+dapzj5mDrVftya3yBj3A@mail.gmail.com>
Message-ID: <CAFNq8R5qSRh0iEo1en_p8g+z9jgELyOOLPxs7rp-6ZV7OE1Cog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, I am a newbie Linux Kernel learner. I am confused  at memory
protected between user space and kernel space.  In arm, the hardware
support the memory protecting by Domain access register.

But in Linux, it may not take effect in ARM Linux. Because before the
official kernel 2.6.38, I found that both DOMAIN_USER and
DOMAIN_KERNEL all set to DOMAIN_MANAGER(0x3). So, before arm Linux
2.6.38, how to protect the kernel memory from accessing in user space?

By the way, after arm Linux 2.6.38, if CPU_USE_DOMAINS is disabled, is
the kernel domain also set to Client same as user domain?


Regards,
Haifeng Li
