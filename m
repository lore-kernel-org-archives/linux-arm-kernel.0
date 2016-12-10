From: peter@korsgaard.com (Peter Korsgaard)
Date: Sat, 10 Dec 2016 22:15:35 +0100
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
In-Reply-To: <20161210181639.GA5660@afzalpc> (Afzal Mohammed's message of
 "Sat, 10 Dec 2016 23:46:39 +0530")
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
 <20161210181639.GA5660@afzalpc>
Message-ID: <878trntrig.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Afzal" == Afzal Mohammed <afzal.mohd.ma@gmail.com> writes:

Hi,

 > Creating user space executables suitable for Cortex-A !MMU is the
 > distance to reach prompt.

 > Seems no !MMU A-class suitable toolchains are available, the existing
 > !MMU toolchains available are for either M or R class. Looks like
 > FDPIC one's also are so (cc'ing Maxime & Mickeal in case they have
 > some input here).

 > And compiling a suitable compiler failed.

 > Let know if any signposts to travel the remaining distance.

You can build a toolchain and initramfs with Buildroot. Have a look at
the stm32f429 nommu config:

https://git.buildroot.net/buildroot/tree/configs/stm32f429_disco_defconfig

-- 
Bye, Peter Korsgaard
