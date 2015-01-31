From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 31 Jan 2015 12:02:34 +0100
Subject: [PATCH v5 00/13] AT91 pm cleanup for 3.20
In-Reply-To: <54CA30E3.2050301@atmel.com>
References: <1422513316-21509-1-git-send-email-wenyou.yang@atmel.com>
 <54CA30E3.2050301@atmel.com>
Message-ID: <20150131110234.GH4164@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Adding Russ and Dave in Cc)

Hi Nicolas,

On 29/01/2015 at 14:08:51 +0100, Nicolas Ferre wrote :
> 2/ try to figure out if from this big amount of assembly code can't be
> extracted some parts that can be converted to C or parts that can use
> ARM common code (for cache management for instance).
> 

To avoid using so much asm, the plan would be to revive that series from
Russ:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198778.html

It will also allow to avoid the __arm_ioremap_exec in pm.c

Russ, do you know what was missing to get it included? I could only find
that series submitted recently:
https://lkml.org/lkml/2014/11/26/575


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
