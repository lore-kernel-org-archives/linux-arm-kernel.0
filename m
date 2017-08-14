From: aik@ozlabs.ru (Alexey Kardashevskiy)
Date: Mon, 14 Aug 2017 23:21:05 +1000
Subject: SUN8I_EMAC driver wanted (for Orange Pi)
In-Reply-To: <92615469-ba27-9c93-9915-872de3c42462@ozlabs.ru>
References: <3792055e-d56f-e722-d9f8-519b46fd73dd@ozlabs.ru>
 <20170813154920.GA31401@lunn.ch>
 <92615469-ba27-9c93-9915-872de3c42462@ozlabs.ru>
Message-ID: <76df0ea9-e875-c1bc-97ab-670e917ecfcb@ozlabs.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/17 10:54, Alexey Kardashevskiy wrote:
> On 14/08/17 01:49, Andrew Lunn wrote:
>> On Mon, Aug 14, 2017 at 01:09:15AM +1000, Alexey Kardashevskiy wrote:
>>> Hi!
>>>
>>> I have been using v4.8 with some driver I found somewhere. Ported to v4.13,
>>> it does not work anymore and I wonder if anyone has an idea where to get a
>>> working one from?
>>
>> Hi Alexey
>>
>> A driver for this was added to Linux May 31st. Try 4.13-rcX enabling
>> DWMAC_SUN8I.
> 
> Thanks, works nicely!


Aaand it stopped with the only message in dmesg (I was trying to enable
video on that pi but I removed DRM and everything and still seeing this):


114 [    0.816334] dwmac-sun8i 1c30000.ethernet: MAC IRQ configuration
information not found

eth0 does not appear in the system, what am I missing now? Thanks!


-- 
Alexey
