From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Jul 2016 14:19:07 +0200
Subject: [PATCH v5 00/44] dma-mapping: Use unsigned long for dma_attrs
In-Reply-To: <20160712121625.GP23520@phenom.ffwll.local>
References: <1467275019-30789-1-git-send-email-k.kozlowski@samsung.com>
 <20160712121625.GP23520@phenom.ffwll.local>
Message-ID: <5784E03B.6060000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2016 02:16 PM, Daniel Vetter wrote:
> On Thu, Jun 30, 2016 at 10:23:39AM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>>
>> This is fifth approach for replacing struct dma_attrs with unsigned
>> long.
>>
>> The main patch (1/44) doing the change is split into many subpatches
>> for easier review (2-42).  They should be squashed together when
>> applying.
> 
> For all the drm driver patches:
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Should I pull these in through drm-misc, or do you prefer to merge them
> through a special topic branch (with everything else) instead on your own?
> -Daniel

Thanks. I saw today that Andrew Morton applied the patchset so I think
he will handle it.

Best regards,
Krzysztof
