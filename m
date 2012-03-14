From: khilman@ti.com (Kevin Hilman)
Date: Wed, 14 Mar 2012 10:22:38 -0700
Subject: [GIT PULL] cpufreq: OMAP updates for v3.4
In-Reply-To: <CANOLnON91vXWb2L-FXjz3sqq-9j5SaEodtpt_yvFiN33D4Q3Ow@mail.gmail.com>
 (Grazvydas Ignotas's message of "Wed, 14 Mar 2012 18:41:51 +0200")
References: <87y5rci2na.fsf@ti.com>
 <CANOLnON91vXWb2L-FXjz3sqq-9j5SaEodtpt_yvFiN33D4Q3Ow@mail.gmail.com>
Message-ID: <87wr6ngkrl.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grazvydas Ignotas <notasas@gmail.com> writes:

[...]

>> Russell King (1):
>> ? ? ?cpufreq: OMAP driver depends CPUfreq tables
>
> It seems this one got messed up, it says "default ARCH_OMAP2PLUS"
> instead of depends.

That was intentional.  What do you think is messed up about it?

It's the same as saying:

     depends on ARCH_OMAP2PLUS
     default y

Kevin
