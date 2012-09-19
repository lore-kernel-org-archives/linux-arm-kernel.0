From: wmb@firmworks.com (Mitch Bradley)
Date: Thu, 20 Sep 2012 05:25:04 +0800
Subject: [PATCH V6 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <201209191424.56086.arnd@arndb.de>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
 <20120919140705.GB16522@beef> <201209191424.56086.arnd@arndb.de>
Message-ID: <505A3830.7090307@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/19/2012 10:24 PM, Arnd Bergmann wrote:
> On Wednesday 19 September 2012, Matt Porter wrote:
>>> +Optional properties:
>>> +- #dma-channels:     Number of DMA channels supported by the controller.
>>> +- #dma-requests:     Number of DMA requests signals supported by the
>>> +                     controller.
>>
>> Shouldn't these two optional properties drop the prefix #?  By
>> convention adopted from the various original OF/ePAPR/etc specs, the
>> only properties I would expect to see with this prefix are the
>> "*-cells" cell sizes. A quick search indicates this is the case
>> throughout all the current bindings.
> 
> I always assumed that the # prefix is used to indicate that we are counting
> things instead of listing them.

Your assumption is historically correct.  It seems that usage has
drifted somewhat.


> 
> 	Arnd
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
