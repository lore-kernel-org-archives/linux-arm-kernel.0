From: stefan@agner.ch (Stefan Agner)
Date: Wed, 24 May 2017 23:48:02 -0700
Subject: [PATCH V2 4/5] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <20170525062347.GT26102@dragon>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-5-git-send-email-aisheng.dong@nxp.com>
 <5e78ef100319f229a87e33804384e5b3@agner.ch>
 <DBXPR04MB320A55DE4386DE561A1D4DC80F90@DBXPR04MB320.eurprd04.prod.outlook.com>
 <20170525031620.GS26102@dragon>
 <AM3PR04MB3068FA0B94C9B0D6269FC9C80FF0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <20170525062347.GT26102@dragon>
Message-ID: <aa6e1f28d21c74cb38a85daba79f2dbe@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-24 23:23, Shawn Guo wrote:
> On Thu, May 25, 2017 at 05:04:58AM +0000, A.S. Dong wrote:
>> If we really want to change, 'IMX7ULP1' may be a little strange as 'IMX7ULP' is
>> the official external name and all other places are using it.
>> So IMX7ULP may be more suitable.
> 
> Yes, I actually meant IMX7ULP, which matches how we name the SoC
> elsewhere in the kernel.
> 

All the other arch/arm/boot/dts/imx*pinfunc.h use MX7ULP (without the
I), but I am fine with either one.

--
Stefan

>>
>> Then next generation may be:
>> IMX7ULP0_PAD_PTC0_PTC0.
>> Vs
>> IMX7ULP_PAD_PTC0_PTC0
>>
>> Just not much better than:
>> ULP1_PAD_PTC0_PTC0.
>> vs
>> ULP0_PAD_PTC0_PTC0
>>
>> That's why I did not do it initially.
>>
>> However, if you do want the change, i'm okay to do it.
> 
> For the next generation, we will have a name for it in the kernel
> anyway.  The pinctrl macro simply follows that name.
> 
> Shawn
