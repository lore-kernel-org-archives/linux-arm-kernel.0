From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 31 Jan 2012 16:32:48 +0530
Subject: [PATCH V1] arm: tegra: dma: not required to move requestor when
 stopping.
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178CB81E5F@HQMAIL01.nvidia.com>
References: <1327392649-27605-1-git-send-email-ldewangan@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178CB81E5F@HQMAIL01.nvidia.com>
Message-ID: <4F27CA58.2020809@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 January 2012 02:27 AM, Stephen Warren wrote:
> Laxman Dewangan wrote at Tuesday, January 24, 2012 1:11 AM:
>> It is not require to move the requestor of dma to INVALID
>> option before stopping dma.
>>
>> Signed-off-by: Laxman Dewangan<ldewangan@nvidia.com>
> Acked-by: Stephen Warren<swarren@nvidia.com>
> Tested-by: Stephen Warren<swarren@nvidia.com>
>
> I know that Laxman has checked with the HW engineers, and they see no
> reason to do this. I was originally worried about hung FIFOs preventing
> an in-progress DMA from completely without the removed code, but according
> to HW, that isn't a concern.
>
Olaf,
Can it be applied if it is OK to you?

Thanks,
Laxman
