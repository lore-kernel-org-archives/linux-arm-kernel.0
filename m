From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 20 Jul 2017 13:01:24 +0200
Subject: [PATCH 0/2] fixed ethernet binding violation for reset signal
In-Reply-To: <1500520073.25149.2.camel@mtkswgap22>
References: <cover.1498030300.git.sean.wang@mediatek.com>
 <1500520073.25149.2.camel@mtkswgap22>
Message-ID: <29c1debd-e7ac-9858-6969-cff37ae1d06f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/20/2017 05:07 AM, Sean Wang wrote:
> Hi, Matthias
> 
> just a gentle ping on this
> 

Pushed now to v4.13-next/dts32

Thanks!

> 	Sean
> 
> 
> On Wed, 2017-06-21 at 15:49 +0800, sean.wang at mediatek.com wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>> Fixed binding violation and also updated related binding documentation to
>> reflect the reset signals the MediaTek Ethernet requires.
>>
>> Sean Wang (2):
>>    dt-bindings: net: mediatek: update documentation for reset signals
>>    arm: dts: mt7623: fixup binding violation missing reset in ethernet
>>      node
>>
>>   Documentation/devicetree/bindings/net/mediatek-net.txt | 6 ++++--
>>   arch/arm/boot/dts/mt7623.dtsi                          | 4 ++++
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
> 
> 
