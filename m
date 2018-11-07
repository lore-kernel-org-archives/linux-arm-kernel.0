From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 7 Nov 2018 14:19:01 +0100
Subject: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
In-Reply-To: <20181107130810.GA18223@kunai>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
 <20181107085056.GB31092@kunai>
 <7154affe-751a-7cb4-48ea-3d4d6f467ac8@gmail.com>
 <20181107130810.GA18223@kunai>
Message-ID: <f7d99456-f68f-7880-f22e-8bd47a546e82@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2018 02:08 PM, Wolfram Sang wrote:
> 
>> Nope. I tried that patchset on M3N again yesterday and got error -84
>> while initing the eMMC, so I need to look into that first. Then I'll
>> try it on E3.
> 
> Hmmm, we tried M3N at the hackfest and it worked great there.
> 
> First idea: are you sure you have all depending patch series applied as
> well?
> 
> @Niklas: Have you/can you push a publich branch out with everything
> included.

We discussed this on IRC already, which is why I need to look into that.
The HS200 works well on the M3N though.

-- 
Best regards,
Marek Vasut
