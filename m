From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 25 Jan 2013 08:07:19 -0500
Subject: [BUG] panda board locks up on boot
In-Reply-To: <0247700D01F14443B9209F90AD938CC52409708C@sestoex09.enea.se>
References: <1359082886.21576.199.camel@gandalf.local.home>
 <51022FD2.8090101@compulab.co.il>
 <0247700D01F14443B9209F90AD938CC52409708C@sestoex09.enea.se>
Message-ID: <1359119239.21576.213.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-25 at 08:43 +0000, Mats Liljegren wrote:
> Hi Steven,
> 
> Do you have CONFIG_CPU_FREQ enabled? As I posted earlier in
> linux-kernel forum ("Failed booting PandaBoard ES with Linux 3.8 RC4"
> two days ago) my PandaBoard ES hangs while booting with this option
> enabled. It works fine without it. I have not bisected it down to a
> single commit though.
> 

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is not set
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=y


I guess that's not the issue I have.

Thanks,

-- Steve
