From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 19 Oct 2012 14:36:31 +0530
Subject: [PATCH 1/5] ARM: tegra: Add slink controller base address
In-Reply-To: <50808526.1080504@wwwdotorg.org>
References: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
 <1350557795-31487-2-git-send-email-ldewangan@nvidia.com>
 <50808526.1080504@wwwdotorg.org>
Message-ID: <50811817.1070806@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 October 2012 04:09 AM, Stephen Warren wrote:
> On 10/18/2012 04:56 AM, Laxman Dewangan wrote:
>> Add base address of all slink controller of Tegra20
>> and tegra30.
> Lets not add anything to iomap.h; we're trying to remove it. Instead,
> just put the raw address in the AUXDATA; I assume that's the only place
> these defines end up being used...
OK, I will drop this change and add the base address definition in the 
AUXDATA file only.
