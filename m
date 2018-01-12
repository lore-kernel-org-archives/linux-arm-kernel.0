From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Fri, 12 Jan 2018 10:38:16 -0600
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <VI1PR04MB20788AC2E71A3CFFC37B85BB9A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <VI1PR04MB2078DBC9381EA574CE5DA4B09A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180109214332.ejiak6f35tnhbpke@pd.tnic>
 <VI1PR04MB20788AC2E71A3CFFC37B85BB9A100@VI1PR04MB2078.eurprd04.prod.outlook.com>
Message-ID: <bc8d7450-3f58-95c2-42c2-d16b2f7a76e4@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2018 03:51 PM, York Sun wrote:
> On 01/09/2018 01:43 PM, Borislav Petkov wrote:
>> Adding some more people to CC.
>>
>> On Tue, Jan 09, 2018 at 08:48:43PM +0000, York Sun wrote:
>>> Borislav,
>>>
>>> Are you aware of any existing (or in development) EDAC driver for ARMv8
>>> L1/L2 cache? I am thinking to write one if not available yet.
>>
>> no I'm not but I see two EDAC drivers for ARM64: thunderx and xgene.
>>
>> Please synchronize with their authors and ARM people what would be the
>> best thing to do and try extracting shared functionality from them
>> into a common compilation unit instead of duplicating it. I don't want
>> separate drivers per functional unit.
>>
> 
> Thanks for the pointer. Thunderx and xgene's drivers have different
> implementation on the hardware. I found one patch closer to what I
> expect, https://patchwork.kernel.org/patch/7513231/. I don't see
> activities after 2015. I will reach out to the author.
> 
> York
> 

Hi York,

I'll be adding EDAC support for our Stratix10 (Quad ARM Cortex A-53) at 
some point but I'm not sure when it is scheduled - probably in the next 
few months. I'll be going through the same process of comparing our 
architecture to others. Below are links to the Stratix10.

https://www.altera.com/products/soc/portfolio/stratix-10-soc/overview.html
https://www.altera.com/products/soc/portfolio/stratix-10-soc/support.html


> --
> To unsubscribe from this list: send the line "unsubscribe linux-edac" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
