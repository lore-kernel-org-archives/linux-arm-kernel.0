From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Jun 2010 10:12:34 +0100
Subject: [RFC PATCH 0/4] ARM: add support for hw-breakpoints [v3]
In-Reply-To: <1276181997-20677-1-git-send-email-will.deacon@arm.com>
References: <1276181997-20677-1-git-send-email-will.deacon@arm.com>
Message-ID: <000b01cb0d34$0f09ebc0$2d1dc340$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> This is version 3 of the RFC patches originally posted at:
> 
> v1.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/009084.html
> v2.) http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011170.html
> 
> Changes from v2 include:
> 	- Based on 2.6.35-rc2
> 	- Updated to use new hw-breakpoint API features
> 	- Addressed some comments from Frederic on LKML
> 	- Complete redesign of the ptrace interface so that it
> 	  follows the ARM ARM (v7) register structure more closely.
> 
> Unfortunately, I've only managed to compile-test this and check that the
> resulting image boots. The main reasons for posting are (a) to support
> current GDB development and (b) to attract comments on the code.

I've managed to do some preliminary testing using the GDB work
in progress and found a few coding howlers. Rather than submit
a new patchset, I'll keep an up-to-date patch series, rebased
against the latest mainline tag here:

http://www.linux-arm.org/git?p=linux-2.6-wd.git;a=shortlog;h=refs/heads/hw-breakpoint

Once the GDB work is complete, I'll submit v4 to this list.

Cheers,

Will
