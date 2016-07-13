From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 13 Jul 2016 09:15:29 +0100
Subject: [PATCH v9 00/17] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <HE1PR04MB1321470CDA673EDB88B8930DFF310@HE1PR04MB1321.eurprd04.prod.outlook.com>
References: <20160713015909.28793-1-andre.przywara@arm.com>
 <HE1PR04MB1321470CDA673EDB88B8930DFF310@HE1PR04MB1321.eurprd04.prod.outlook.com>
Message-ID: <ed267877-0071-1cf3-d173-4eedfd183c10@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Diana,

On 13/07/16 08:57, Diana Madalina Craciun wrote:
> Hi Andre,
> 
> On 07/13/2016 04:59 AM, Andre Przywara wrote:
>> To test this you can use the kvmtool patches available in the "its-v6"
>> branch here [2].
>> Start a guest with: "$ lkvm run --irqchip=gicv3-its --force-pci"
>> and see the ITS being used for instance by the virtio devices.
>>
>> [1]: git://linux-arm.org/linux-ap.git
>>      http://www.linux-arm.org/git?p=linux-ap.git;a=log;h=refs/heads/its-emul/v9
>> [2]: git://linux-arm.org/kvmtool.git
> 
> It seems that its/emul/v9 branch does not exist.

I could claim it was just a test to see whether someone cares ;-), but
in fact I just forgot it.
Just pushed it now, please try again!

Thanks,
Andre.
