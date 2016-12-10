From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sat, 10 Dec 2016 23:46:39 +0530
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20161210181639.GA5660@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 02, 2016 at 03:05:18PM +0000, Vladimir Murzin wrote:

> there was little interest to run A-class with MMU disabled (or
> 1:1 MMU mapping) as well.

With a few more changes, on a Cortex-A platform, Kernel reached
maximum it can proceed w/o user space help, i.e. upto,

"Kernel panic - not syncing: No working init found."

Creating user space executables suitable for Cortex-A !MMU is the
distance to reach prompt.

Seems no !MMU A-class suitable toolchains are available, the existing
!MMU toolchains available are for either M or R class. Looks like
FDPIC one's also are so (cc'ing Maxime & Mickeal in case they have
some input here).

And compiling a suitable compiler failed.

Let know if any signposts to travel the remaining distance.

PS: Version used was v2 instead of this v3 series.

Regards
afzal
