From: jason@tensyr.com (Jason Teplitz)
Date: Thu, 7 Sep 2017 12:36:48 -0700
Subject: Conflict when accessing PMU counters from userspace
Message-ID: <CALk3wS0P-R9=HU1wYCWWYZ2w=7RjFoD4M=Vwzg-1ALRuRNMHUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm reading the PMU counters from a userspace process, but the cycle
counter keeps getting reset. I don't believe any other running
processes are doing this. Is there something in the kernel that resets
the cycle counter periodically and if so is there an easy way to
disable it?

-Jason
