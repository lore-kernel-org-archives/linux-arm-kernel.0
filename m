From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 19 Apr 2017 14:24:14 -0700
Subject: [PATCH] soc: bcm: brcmstb: Correctly match 7435 SoC
In-Reply-To: <CADtm3G5yJhM8cfqS_xbp2TjWxsB_ipfsL5oFoMq_1SH-mW3rHA@mail.gmail.com>
References: <20170419170136.4979-1-f.fainelli@gmail.com>
 <CADtm3G5yJhM8cfqS_xbp2TjWxsB_ipfsL5oFoMq_1SH-mW3rHA@mail.gmail.com>
Message-ID: <270694a5-3ef0-25b4-2baf-6f8f0f1b714a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2017 01:28 PM, Gregory Fong wrote:
> On Wed, Apr 19, 2017 at 10:01 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> Remove the duplicate brcm,bcm7425-sun-top-ctrl compatible string and
>> replace it with brcm,bcm7435-sun-top-ctrl which was intentend.
> 
> s/intentend/intended/
> 
>>
>> Fixes: bd0faf08dc7f ("soc: bcm: brcmstb: Match additional compatible strings")
>> Reported-by: Andreas Oberritter <obi@saftware.de>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
> 

Fixed the typo and applied with your Acked-by, thanks Gregory!
-- 
Florian
