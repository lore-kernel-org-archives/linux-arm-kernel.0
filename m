From: york.sun@nxp.com (York Sun)
Date: Thu, 14 Sep 2017 19:57:40 +0000
Subject: [PATCH] config: ls1012aqds: Add USB EHCI support for ls1012aqds
References: <1501148945-11775-1-git-send-email-yinbo.zhu@nxp.com>
 <VI1PR04MB20781CC22A5EDB904EF1D3259A6F0@VI1PR04MB2078.eurprd04.prod.outlook.com>
Message-ID: <VI1PR04MB2078F1440F89F002F40140C19A6F0@VI1PR04MB2078.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2017 12:54 PM, York Sun wrote:
> On 07/27/2017 03:05 AM, yinbo.zhu at nxp.com wrote:
>> From: Rajesh Bhagat <rajesh.bhagat@nxp.com>
>>

<snip>

>> +#elif defined(CONFIG_LS102XA) || defined(CONFIG_ARCH_LS1012A)
> 
> Please use CONFIG_ARCH_LS1021A, not CONFIG_LS102XA.
> 

Never mind. This is merged. I will send a patch to fix it.

York
