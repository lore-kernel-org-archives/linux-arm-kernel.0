From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 3 Jun 2016 15:32:01 +0100
Subject: [PATCH v4 00/12] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <DB5PR04MB099754E61027226E5210C2399A590@DB5PR04MB0997.eurprd04.prod.outlook.com>
References: <1458958450-19662-1-git-send-email-andre.przywara@arm.com>
 <DB5PR04MB099754E61027226E5210C2399A590@DB5PR04MB0997.eurprd04.prod.outlook.com>
Message-ID: <32b86adb-cdba-89bb-3f19-e7677f39fa1f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bharat,

On 03/06/16 05:26, Bharat Bhushan wrote:
> Hi Andre,
> 
> We are looking for these patches but seems like these needed to
> rebased/redesigned based on new GIC emulation changes. Can you give us
> some sense on when this will be done?
> Also do you know if someone is working on QEMU size changes for
> this, if not then we can help on getting that done.

I just pushed a new version of the patches:
https://lists.cs.columbia.edu/pipermail/kvmarm/2016-June/020482.html

I hope that answers your question about the kernel side of things.
For QEMU I have no idea, maybe Christoffer or Peter would know.

Cheers,
Andre.
