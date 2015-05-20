From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 May 2015 16:08:56 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add Atmel SAMA5 family
In-Reply-To: <CAMAWPa95VTM+VgNpcs1oZwX9NqzrL1JeNy=MqL0Zo3JP=svyUQ@mail.gmail.com>
References: <1428051678-20450-1-git-send-email-alexandre.belloni@free-electrons.com>
 <555AFF3F.10400@atmel.com> <9986808.t62JLgg5NJ@wuerfel>
 <20150519123358.GA15179@piout.net> <555B3463.2060700@atmel.com>
 <555B3A92.7010409@atmel.com> <555B4040.2090302@atmel.com>
 <CAMAWPa95VTM+VgNpcs1oZwX9NqzrL1JeNy=MqL0Zo3JP=svyUQ@mail.gmail.com>
Message-ID: <20150520140856.GE3907@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/05/2015 at 06:53:50 -0700, Kevin Hilman wrote :
> FYI... This patch is now in linux-next, and boot tests for all the
> sama5d[34] boards in kernelci.org have failed to boot.
> 
>    http://kernelci.org/boot/all/job/next/kernel/next-20150520/
> 

Hum, I'm pretty sure you see the heartbeat led blinking ;)

I think I told you a while ago on IRC and this is part of the commit
message. You have to use ttyAT0 instead of ttyS0 in your bootargs. I'm
not sure how I can make that more obvious, I'm open to any idea.

I'm planning to send a series adding stdout-path to the atmel boards
when I'm back next week. Hopefully this will solve that issue.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
