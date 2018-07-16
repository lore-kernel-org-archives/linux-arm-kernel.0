From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 16 Jul 2018 10:34:12 +0100
Subject: [PATCH 0/2] Support ARMv8R
In-Reply-To: <1531129858-8341-1-git-send-email-vladimir.murzin@arm.com>
References: <1531129858-8341-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <ad460509-5fb2-badf-32d2-4fda07244e65@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/18 10:50, Vladimir Murzin wrote:
> ARMv8R brings set of new features. Some of them, like PMSAv8, have
> already been merged, so these patches add missing features for bare
> minimimum support of ARMv8R.
> 

Ok for patch tracker?

> Thanks!
> 
> Vladimir Murzin (2):
>   ARM: NOMMU: Extend check for VBAR support
>   ARM: NOMMU: Allow enter in Hyp mode
> 
>  arch/arm/kernel/head-nommu.S | 12 ++++++++++--
>  arch/arm/mm/Kconfig          |  1 -
>  arch/arm/mm/nommu.c          |  3 ++-
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
