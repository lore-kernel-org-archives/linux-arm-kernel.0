From: arend@broadcom.com (Arend van Spriel)
Date: Tue, 12 Apr 2011 15:27:59 +0200
Subject: [RFC][PATCH] axi: add AXI bus driver
In-Reply-To: <BANLkTiksJmiiK53kcP6vm6CTmzXhQa7oTA@mail.gmail.com>
References: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
	<BANLkTi=jV12tOR_=idn0z+oO_RQ2xaFhCQ@mail.gmail.com>
	<op.vtttxt083ri7v4@arend-laptop>
	<BANLkTiksJmiiK53kcP6vm6CTmzXhQa7oTA@mail.gmail.com>
Message-ID: <op.vttucxh73ri7v4@arend-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2011 15:21:44 +0200, Rafa? Mi?ecki <zajec5@gmail.com> wrote:

> 2011/4/12 Arend van Spriel <arend@broadcom.com>:
>> On Tue, 12 Apr 2011 15:04:48 +0200, Rafa? Mi?ecki <zajec5@gmail.com>  
>> wrote:
>>
>>> There is one more change I started to consider. Is "core" correct name
>>> for AXI's device? Almost everywhere we can read about *components* on
>>> the AXI interconnect.
>>>
>>> Maybe it'd make sense to s/core/comp/? Arend?
>>
>> I have no strong preference on this. I tried the latest patch and it  
>> does
>> not crash anymore with load/unload.
>
> Could you post dmesg? Probably nothing exciting, just my curiosity :)
>
Apr 12 11:56:52 arend-laptop kernel: [ 6615.077417] axi-pci-bridge  
0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Apr 12 11:56:52 arend-laptop kernel: [ 6615.078690] axi: Core 0 found:  
ChipCommon (manuf 0x4BF, id 0x800, rev 0x22, class 0x0)
Apr 12 11:56:52 arend-laptop kernel: [ 6615.079215] axi: Core 1 found:  
IEEE 802.11 (manuf 0x4BF, id 0x812, rev 0x17, class 0x0)
Apr 12 11:56:52 arend-laptop kernel: [ 6615.079777] axi: Core 2 found:  
PCIe (manuf 0x4BF, id 0x820, rev 0x0F, class 0x0)
Apr 12 11:56:52 arend-laptop kernel: [ 6615.111608] axi: AXI registered
Apr 12 11:57:25 arend-laptop kernel: [ 6648.556024] axi-pci-bridge  
0000:03:00.0: PCI INT A disabled

Happy to satisfy your curiosity.

Gr. AvS
-- 
"The world is indeed comic, but the joke is on mankind." ? H.P. Lovecraft
