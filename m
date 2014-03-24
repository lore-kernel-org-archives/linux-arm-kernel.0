From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Mon, 24 Mar 2014 21:36:25 +0100
Subject: [PATCH 1/3] IXP4xx: Fix Goramo Multilink GPIO conversion.
In-Reply-To: <CACRpkdaNdQjgAJv=mxn6MXS+kGKFoE4wmNHxYt_5WdM9sa6vxA@mail.gmail.com>
 (Linus Walleij's message of "Mon, 24 Mar 2014 16:27:47 +0100")
References: <m3siq9iyt2.fsf@intrepid.localdomain>
 <m3bnwxiwhj.fsf@intrepid.localdomain>
 <CACRpkdaNdQjgAJv=mxn6MXS+kGKFoE4wmNHxYt_5WdM9sa6vxA@mail.gmail.com>
Message-ID: <m3mwgf72ra.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

>> arch/arm/mach-ixp4xx/goramo_mlr.c:416: error: 'IXP4XX_GPIO_OUT' undeclared
>> arch/arm/mach-ixp4xx/goramo_mlr.c:421: error: 'IXP4XX_GPIO_IN' undeclared
>>
>> Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
>
> Alternatively can you send this for fixes to arm at kernel.org with Cc:
> stable added Krzysztof?

Given the platform's specifics, I guess it's enough to just fix it in
mainline.
-- 
Krzysztof Halasa
