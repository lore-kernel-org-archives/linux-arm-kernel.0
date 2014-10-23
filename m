From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 Oct 2014 14:26:57 +0200
Subject: [PATCH 0/4] Make Armada 375 use the reference clock when possible
In-Reply-To: <5448F1A1.9040404@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022155614.04d33791@free-electrons.com>
 <5448F1A1.9040404@free-electrons.com>
Message-ID: <20141023142657.6b4d61fb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Thu, 23 Oct 2014 09:16:33 -0300, Ezequiel Garcia wrote:

> > You don't clearly state whether your patch series keep compatibility
> > with the 375 Z1 or not. And in fact, it doesn't keep compatibility with
> > Z1. I'm fine with that, but then it means we should officially declare
> > the Z1 support in mainline as dead, and get rid of the workarounds that
> > applied only to 375 Z1.
> 
> How many people have Z1 boards? And is someone actually using one for
> something? Do we have any other reason to support Z1?
> 
> FWIW, a v3.18-rc1 kernel built with mvebu_v7_defconfig, silently stalls
> in the middle of the boot on Z1. Had to remove lots of compile time
> options to make it boot.
> 
> Before I start digging into this, maybe we can discuss your suggestion
> to drop it. If nobody is booting this often enough, maybe nobody cares
> about this, and it makes sense to drop the support?

Marvell has always said they are not interested in having Z1 supported
in mainline, except as a first step to start getting the 375 support in
mainline. I have been waiting for everyone of us to have access to 375
A0 platforms, which is now the case. So I believe we can probably get
rid of the 375 Z1 support entirely.

It saddens me to know that a shiny development board in the office will
no longer be useful for anything else but its own physical beauty, but
I believe that's a normal retirement strategy for a very early
development platform :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
