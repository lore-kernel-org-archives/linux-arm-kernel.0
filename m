From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Jun 2016 10:30:46 -0700
Subject: [PATCH 2/3] hw_random: bcm2835: Add support for Broadcom BCM5301x
In-Reply-To: <20160624133122.GC21111@gondor.apana.org.au>
References: <1466641623-3491-1-git-send-email-f.fainelli@gmail.com>
 <1466641623-3491-3-git-send-email-f.fainelli@gmail.com>
 <20160624133122.GC21111@gondor.apana.org.au>
Message-ID: <576D6E46.5000906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2016 06:31 AM, Herbert Xu wrote:
> On Wed, Jun 22, 2016 at 05:27:02PM -0700, Florian Fainelli wrote:
>> The Broadcom BCM5301x SoCs (Northstar) utilize the same random number
>> generator peripheral as Northstar Plus and BCM2835, but just like the
>> NSP SoC, we need to enable the interrupt.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Patch applied.
> 

Thanks! Do you mind taking patch 1 as well? I will take patch 3 via my
arm-soc tree.
-- 
Florian
