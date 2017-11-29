From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 29 Nov 2017 09:38:52 -0800
Subject: [v2,01/12] hwrng: bcm2835 - Obtain base register via resource
In-Reply-To: <20171129063028.GB21594@gondor.apana.org.au>
References: <20171108004449.32730-2-f.fainelli@gmail.com>
 <20171129063028.GB21594@gondor.apana.org.au>
Message-ID: <ac49deb2-6f81-1daf-596d-16fd6bd6af32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2017 10:30 PM, Herbert Xu wrote:
> On Tue, Nov 07, 2017 at 04:44:38PM -0800, Florian Fainelli wrote:
>> In preparation for consolidating bcm63xx-rng into bcm2835-rng, make sure
>> that we obtain the base register via platform_get_resource() since we
>> need to support the non-DT enabled MIPS-based BCM63xx DSL SoCs.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> All applied.  Thanks.

Hu, okay, I actually had a v3 prepared that I was going to post
addressing some of the comments. Should I send an incremental set of
changes now?
-- 
Florian
