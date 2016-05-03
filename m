From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 3 May 2016 11:22:17 +0100
Subject: [PATCH v2 0/3] ARM: nommu: R-class fixes
In-Reply-To: <1461862316-9877-1-git-send-email-vladimir.murzin@arm.com>
References: <1461862316-9877-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57287BD9.6090907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/04/16 17:51, Vladimir Murzin wrote:
> Small set of fixes discovered with R-class cores.
> 
> Jean-Philippe Brucker (2):
>   ARM: nommu: fix PMSAv7 setup
>   ARM: nommu: change memory reserve for the vectors
> 
> Vladimir Murzin (1):
>   ARM: domain: move {set,get}_domain under config guard
> 
>  arch/arm/include/asm/domain.h |   11 +++++++++++
>  arch/arm/kernel/head-nommu.S  |    2 +-
>  arch/arm/mm/nommu.c           |   15 ++++++++-------
>  3 files changed, 20 insertions(+), 8 deletions(-)
> 

Russell, any objection to get it into patch tracker?

Thanks
Vladimir
