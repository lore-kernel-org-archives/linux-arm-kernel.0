From: wni@nvidia.com (Wei Ni)
Date: Mon, 18 Jun 2012 14:00:33 +0800
Subject: Where to power on the wifi device before loading the driver.
In-Reply-To: <4FDB61C9.9020505@broadcom.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
 <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
 <4FDB61C9.9020505@broadcom.com>
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61E@HKMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 16, 2012 at 00:24:41, Franky Lin wrote:
>On 06/14/2012 11:09 PM, Wei Ni wrote:
>> I talked with Franky, this power sequence is generally for 4329, so it mean this sequence can be put into the wifi driver.
>
>Hold on. It's generally for 4329. But fullmac supports 4329/4330 along 
>with USB dongle chips. Also more chips are incoming. I dont think it's a good idea to add *this* power sequence into brcmfmac.

Ok we need find other ways for it. Thanks for your comments.

Wei
---
nvpublic
