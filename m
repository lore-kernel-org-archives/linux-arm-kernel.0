From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 23 Dec 2016 11:27:24 +0200
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
In-Reply-To: <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
 <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
 <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com>
 <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
Message-ID: <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2016 10:32 AM, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Dec 23, 2016 at 10:20:20AM +0200, Vladimir Zapolskiy wrote:
>> On 12/23/2016 03:55 AM, Guenter Roeck wrote:
>>> What is the ultimate conclusion of this exchange ?
>>>
>>> Are we going to get another version of the patch, or did everyone agree that
>>> the patch is good as it is and does not require further changes ?
>>>
>>
>> I can not imagine a different fix.
> 
> my preferred fix would be:
> 
>  - add an imx35 compatible to all newer dtsi
>  - update the driver to only write the wmcr on imx35 compatible devices
>    adding only imx35.
> 

It breaks old DTS vs. new kernel compatibility, I've already mentioned this.

--
With best wishes,
Vladimir
