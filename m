From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Jan 2016 09:34:25 +0900
Subject: [PATCH 0/8] rtc: max77686: Extend driver and add max77802 support
In-Reply-To: <20160121003047.GF3367@piout.net>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
 <20160121003047.GF3367@piout.net>
Message-ID: <56A02791.9010409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.01.2016 09:30, Alexandre Belloni wrote:
>> I believe all patches should go through the RTC tree with proper acks or
>> wait until the RTC patches land to pick the defconfig changes.
>>
> 
> I think Olof would prefer the last patches to go through arm-soc.

That would be preferred but merging them before the 5/8 would cause a
loss of functionality on these defconfigs making it non-bisectable
approach. I think it would be good to preserve bisectability in that
matter so either:
1. a tag from RTC on top of which these patches would be applied in arm-soc,
2. take them to RTC tree with our acks.

Best regards,
Krzysztof
