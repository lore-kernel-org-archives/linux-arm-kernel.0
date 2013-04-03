From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 3 Apr 2013 12:05:30 +0530
Subject: [PATCH v4 0/6] Generic PHY Framework
In-Reply-To: <20130403.023157.1254170239558661397.davem@davemloft.net>
References: <1364449408-9510-1-git-send-email-kishon@ti.com>
 <20130328.143142.2080627792603647441.davem@davemloft.net>
 <515BC559.1070602@ti.com>
 <20130403.023157.1254170239558661397.davem@davemloft.net>
Message-ID: <515BCDB2.2040506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 03 April 2013 12:01 PM, David Miller wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Date: Wed, 3 Apr 2013 11:29:53 +0530
>
>> Hi,
>>
>> On Friday 29 March 2013 12:01 AM, David Miller wrote:
>>>
>>> You really need to CC: netdev at vger.kernel.org rather than me
>>> explicitly
>>> on this patch set.
>>
>> I was CC'ing whatever get_maintainer shows. I'll make sure to CC
>> netdev at vger.kernel.org though there's nothing related to network in
>> this patch series (Maybe sometime in the future it'll be used).
>
> What about drivers/net/phy isn't networking?

This patch series is about drivers/phy which will be used for now by 
usb, sata and maybe some video PHY's. Network itself has a comprehensive 
PHY in drivers/net/phy which we'd like to merge it with drivers/phy so 
that we have all the phy stuff in drivers/phy but we are not planning 
too far ahead here.

Thanks
Kishon
