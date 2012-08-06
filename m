From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Mon, 06 Aug 2012 14:42:28 +0200
Subject: [PATCH 2/2] dma-buf: add helpers for attacher dma-parms
In-Reply-To: <xa1tobmoxmdz.fsf@mina86.com>
References: <1342715014-5316-1-git-send-email-rob.clark@linaro.org>
 <1342715014-5316-3-git-send-email-rob.clark@linaro.org>
 <501F9C8E.4080002@samsung.com> <xa1tobmoxmdz.fsf@mina86.com>
Message-ID: <501FBBB4.6000109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2012 01:58 PM, Michal Nazarewicz wrote:
> 
> Tomasz Stanislawski <t.stanislaws@samsung.com> writes:
>> I recommend to change the semantics for unlimited number of segments
>> from 'value 0' to:
>>
>> #define DMA_SEGMENTS_COUNT_UNLIMITED ((unsigned long)INT_MAX)

Sorry. It should be:
#define DMA_SEGMENTS_COUNT_UNLIMITED ((unsigned int)INT_MAX)

>>
>> Using INT_MAX will allow using safe conversions between signed and
>> unsigned integers.
> 
> LONG_MAX seems cleaner regardless.
> 
> 
> 
