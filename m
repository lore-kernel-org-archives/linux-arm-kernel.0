From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Apr 2016 09:01:20 +0200
Subject: [PATCH 2/3] i2c: s3c2410: Minor function-level comment cleanup
In-Reply-To: <57178B58.7050104@osg.samsung.com>
References: <1461144292-22141-1-git-send-email-k.kozlowski@samsung.com>
 <1461144292-22141-2-git-send-email-k.kozlowski@samsung.com>
 <57178B58.7050104@osg.samsung.com>
Message-ID: <57187AC0.3000503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2016 03:59 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 04/20/2016 05:24 AM, Krzysztof Kozlowski wrote:
>> Cleanup the weird function-level comments and remove obvious
>> documentatoin for probe/remove.
>>
> 
> s/documentatoin/documentation
>  
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> I wonder if instead we should change to kernel-doc formatted documentation.
> 
> All the functions are static so kernel-doc is not really required but still
> Documentation/kernel-doc-nano-HOWTO.txt says that is suggested for source
> code layout consistency.
> 
> But I agree that's either kernel-doc format or minimal as your patch does:
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks for review. Indeed switching to kernel-doc would be the best...
but that would require a little bit more rewritting than now. I just
wanted to fix some weird looking comments.

Best regards,
Krzysztof
