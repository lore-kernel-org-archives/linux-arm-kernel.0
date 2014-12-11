From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 11 Dec 2014 09:14:37 -0500
Subject: [PATCH v7 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <20141210.204110.618599360537141819.davem@davemloft.net>
References: <1417556503-22290-3-git-send-email-m-karicheri2@ti.com>
 <20141209.131053.2026868499542642866.davem@davemloft.net>
 <5488BB96.9070609@ti.com>
 <20141210.204110.618599360537141819.davem@davemloft.net>
Message-ID: <5489A6CD.20909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2014 08:41 PM, David Miller wrote:
> From: Murali Karicheri<m-karicheri2@ti.com>
> Date: Wed, 10 Dec 2014 16:31:02 -0500
>
>> Are you referring to the static code analyser sparse that is invoked
>> through?
>
> You have to explicitly enable endian checking, it's not on by
> default.
Thanks David and others who responded. Let me do this and resolve any 
warning before the next post.

BTW, could you provide any suggestions that would help us merge this 
series to upstream? This has been sitting on this list for a while now.

Thanks and regards,

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
