From: jroedel@suse.de (Joerg Roedel)
Date: Wed, 19 Apr 2017 13:56:58 +0200
Subject: [PATCH v3 0/7] ARM: Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <21ea43fb-0d3d-88e2-12ee-4a114e9d8459@arm.com>
References: <1489137839-549-1-git-send-email-vladimir.murzin@arm.com>
 <90e219f3-7139-c11c-a635-509173d4148a@arm.com>
 <33321273-E3E7-459B-A615-5ADA52445AA1@esh.hu>
 <186f0c06-39ce-cb88-35e5-6dd57aa81166@arm.com>
 <4e3ce329-6194-043b-0d69-cbec6b08e38e@arm.com>
 <21ea43fb-0d3d-88e2-12ee-4a114e9d8459@arm.com>
Message-ID: <20170419115658.GD5077@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 01:51:35PM +0100, Vladimir Murzin wrote:
> FYI, nothing has changed since last "ping" - Andr?s and Alexandre are still
> dependant on this series to safely enable DMA on their platforms. It is really
> scary that these patches do not move forward even though they are supposed to
> fix the real issue :(

That's probably because you didn't include all relevant people in this
post. I think patches the patches for dma-noop.c should go through 
Andrew Morton.



	Joerg
