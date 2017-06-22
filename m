From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Jun 2017 19:22:57 +0100
Subject: [PATCH v9 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
In-Reply-To: <1498133138-20244-1-git-send-email-gakula@caviumnetworks.com>
References: <1498133138-20244-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170622182257.GI15336@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 05:35:35PM +0530, Geetha sowjanya wrote:
> Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
> 1. Errata ID #74
>    SMMU register alias Page 1 is not implemented
> 2. Errata ID #126
>    SMMU doesnt support unique IRQ lines and also MSI for gerror,
>    eventq and cmdq-sync
> 
> The following patchset does software workaround for these two erratas.

I've picked up the first two patches, and left comments on the final patch.

Will
