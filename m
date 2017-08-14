From: aik@ozlabs.ru (Alexey Kardashevskiy)
Date: Mon, 14 Aug 2017 10:54:41 +1000
Subject: SUN8I_EMAC driver wanted (for Orange Pi)
In-Reply-To: <20170813154920.GA31401@lunn.ch>
References: <3792055e-d56f-e722-d9f8-519b46fd73dd@ozlabs.ru>
 <20170813154920.GA31401@lunn.ch>
Message-ID: <92615469-ba27-9c93-9915-872de3c42462@ozlabs.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/17 01:49, Andrew Lunn wrote:
> On Mon, Aug 14, 2017 at 01:09:15AM +1000, Alexey Kardashevskiy wrote:
>> Hi!
>>
>> I have been using v4.8 with some driver I found somewhere. Ported to v4.13,
>> it does not work anymore and I wonder if anyone has an idea where to get a
>> working one from?
> 
> Hi Alexey
> 
> A driver for this was added to Linux May 31st. Try 4.13-rcX enabling
> DWMAC_SUN8I.

Thanks, works nicely!


-- 
Alexey
