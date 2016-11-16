From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 16 Nov 2016 13:58:28 +0100
Subject: [PATCH 0/8] DMA: s3c64xx: Conversion to the new channel request
 API
In-Reply-To: <20161116032620.GV3000@localhost>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
 <CGME20161116031720epcas2p2f0c9017fe5e256a2d69f076af2a3f308@epcas2p2.samsung.com>
 <20161116032620.GV3000@localhost>
Message-ID: <80c362ab-5b37-dc0e-7b45-db0d51adcb13@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2016 04:26 AM, Vinod Koul wrote:
> On Thu, Nov 10, 2016 at 04:17:48PM +0100, Sylwester Nawrocki wrote:
>> This patch series aims to convert the s3c64xx platform to use
>> the new DMA channel request API, i.e. this is only meaningful 
>> for non-dt systems using s3c64xx SoCs.
>>
>> Presumably the first 2 or 4 patches in this series could be queued 
>> for v4.10-rc1 and the remaining patches could be left for subsequent
>> release, to avoid non-trivial conflict with patches already applied 
>> in the ASoC tree.
> 
> I am fine with dma patch (expect the subsystem tag) and others except arm
> ones have acks, so I think we can merge this for v4.10-rc1. I cna create a
> immutable tag and people can merge into their tree in case they have
> dependencies.
> 
> Btw need acks on ARM patches before I can apply

Great, then we an Ack for these 2 patches:

ARM: s3c64xx: Add DMA slave maps for PL080 devices
ARM: s3c64xx: Drop unused DMA fields from struct s3c64xx_spi_csinfo

-- 
Thanks,
Sylwester
