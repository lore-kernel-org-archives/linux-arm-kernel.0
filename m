From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jan 2013 09:56:36 +0000
Subject: [PATCH 2/6] ARM: cache: remove ARMv3 support code
In-Reply-To: <0a6801cdff4b$8ae22940$a0a67bc0$@samsung.com>
References: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
 <1359556069-28289-3-git-send-email-will.deacon@arm.com>
 <0a6801cdff4b$8ae22940$a0a67bc0$@samsung.com>
Message-ID: <20130131095635.GA31959@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 31, 2013 at 12:40:18AM +0000, Hyok S. Choi wrote:
> I know there is no v3 architecture in current platforms in mainline tree,
> but can we _remove_ v3 support codes? IOW, Is there no platform port users
> for ARM7 nommu families(such as ARM700 or ARM710)?

Nope, 610 and 710 support was removed last year with
357c9c1f07d4 ("ARM: Remove support for ARMv3 ARM610 and ARM710 CPUs"). The
only remaining user of cache-v3.S is 740T (grep for CPU_CACHE_V3).

Will
