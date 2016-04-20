From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 20 Apr 2016 09:59:52 -0400
Subject: [PATCH 2/3] i2c: s3c2410: Minor function-level comment cleanup
In-Reply-To: <1461144292-22141-2-git-send-email-k.kozlowski@samsung.com>
References: <1461144292-22141-1-git-send-email-k.kozlowski@samsung.com>
 <1461144292-22141-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <57178B58.7050104@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/20/2016 05:24 AM, Krzysztof Kozlowski wrote:
> Cleanup the weird function-level comments and remove obvious
> documentatoin for probe/remove.
>

s/documentatoin/documentation
 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

I wonder if instead we should change to kernel-doc formatted documentation.

All the functions are static so kernel-doc is not really required but still
Documentation/kernel-doc-nano-HOWTO.txt says that is suggested for source
code layout consistency.

But I agree that's either kernel-doc format or minimal as your patch does:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
