From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 7 Nov 2018 21:35:51 +0100
Subject: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
In-Reply-To: <20181107192345.6cq6hzpqzl6j535b@ninjato>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
 <20181107085056.GB31092@kunai>
 <7154affe-751a-7cb4-48ea-3d4d6f467ac8@gmail.com>
 <20181107130810.GA18223@kunai>
 <f7d99456-f68f-7880-f22e-8bd47a546e82@gmail.com>
 <20181107192345.6cq6hzpqzl6j535b@ninjato>
Message-ID: <b94ce89b-af37-4270-a7ad-1447a88f69fb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2018 08:23 PM, Wolfram Sang wrote:
> 
>> We discussed this on IRC already, which is why I need to look into that.
>> The HS200 works well on the M3N though.
> 
> Can you push the branch you used somewhere? I retested the branch from
> Dunbar with my M3N and it works fine with my tests.

Sure.

btw I think this might even have something to do with ATF 1.0.24 or
mainline U-Boot, which switches the eMMC card to HS200 mode.

-- 
Best regards,
Marek Vasut
