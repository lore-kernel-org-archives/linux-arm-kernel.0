From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 20 Jul 2016 22:58:40 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable PM_DEBUG
In-Reply-To: <0b91df86-02c7-a4ba-4aba-7d3ed0bf28e9@osg.samsung.com>
References: <1468926554-22204-1-git-send-email-k.kozlowski@samsung.com>
 <0b91df86-02c7-a4ba-4aba-7d3ed0bf28e9@osg.samsung.com>
Message-ID: <578F8390.1030101@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/16 23:49, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 07/19/2016 07:09 AM, Krzysztof Kozlowski wrote:
>> PM_DEBUG and PM_ADVANCED_DEBUG bring some information useful for
>> development and they should not cause any significant overhead.  Enable
>> them in default configuration so debugging would be slightly easier.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> I agree that it's good to have these enabled to make debugging easier.
> 
I'm back ;-)

I agreed...so,
Acked-by: Kukjin Kim <kgene@kernel.org>

BTW, I have not seen the kernel log with PM_ADVANCED_DEBUG. Can anyone
show me the log?...to be honest I need to setup the dev. environment on
my desk at this moment...

Thanks,
Kukjin

> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Best regards,
