From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Jan 2017 14:06:43 -0800
Subject: [PATCH net-next v4 00/10] net: dsa: Support for pdata in dsa2
In-Reply-To: <20170118.165050.2165692521961713529.davem@davemloft.net>
References: <20170117232152.1661-1-f.fainelli@gmail.com>
 <20170118.165050.2165692521961713529.davem@davemloft.net>
Message-ID: <c41c6746-9489-80f6-92a9-aa3595ce92c5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2017 01:50 PM, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Tue, 17 Jan 2017 15:21:42 -0800
> 
>> This is not exactly new, and was sent before, although back then, I did not
>> have an user of the pre-declared MDIO board information, but now we do. Note
>> that I have additional changes queued up to have b53 register platform data for
>> MIPS bcm47xx and bcm63xx.
>  ...
> 
> We're waiting for Greg's further review and Vivien's changes which I just
> applied are going to create some conflicts, so I am presuming that you will
> respin a v5 anyways.

Yes indeed. Thanks for your patience!
-- 
Florian
