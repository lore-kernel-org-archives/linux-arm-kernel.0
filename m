From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 24 Jun 2014 19:33:10 +0900
Subject: [PATCH v2 2/3] drm/ttm: introduce dma cache sync helpers
In-Reply-To: <20140624100220.GK32514@n2100.arm.linux.org.uk>
References: <1403603667-11302-1-git-send-email-acourbot@nvidia.com>
 <1403603667-11302-3-git-send-email-acourbot@nvidia.com>
 <20140624100220.GK32514@n2100.arm.linux.org.uk>
Message-ID: <53A953E6.2030503@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2014 07:02 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 24, 2014 at 06:54:26PM +0900, Alexandre Courbot wrote:
>> From: Lucas Stach <dev@lynxeye.de>
>>
>> On architectures for which access to GPU memory is non-coherent,
>> caches need to be flushed and invalidated explicitly at the
>> appropriate places. Introduce two small helpers to make things
>> easy for TTM-based drivers.
>
> Have you run this with DMA API debugging enabled?  I suspect you haven't,
> and I recommend that you do.

# cat /sys/kernel/debug/dma-api/error_count
162621

(??????? ???)
