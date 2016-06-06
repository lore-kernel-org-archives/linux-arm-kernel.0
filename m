From: bharat.bhushan@nxp.com (Bharat Bhushan)
Date: Mon, 6 Jun 2016 05:29:46 +0000
Subject: [PATCH v4 00/12] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <32b86adb-cdba-89bb-3f19-e7677f39fa1f@arm.com>
References: <1458958450-19662-1-git-send-email-andre.przywara@arm.com>
 <DB5PR04MB099754E61027226E5210C2399A590@DB5PR04MB0997.eurprd04.prod.outlook.com>
 <32b86adb-cdba-89bb-3f19-e7677f39fa1f@arm.com>
Message-ID: <DB5PR04MB09977DF578DFB03A582745869A5C0@DB5PR04MB0997.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On clarification, are V5 version of patches are based on new-GIC emulation patches? How are you testing these patches, kvm-tool?

Hi Christoffer/Peter,

Is someone working on QEMU side patches? We need this feature a bit urgently so if no one is working then we can start working on this.

Thanks
-Bharat

> -----Original Message-----
> From: kvmarm-bounces at lists.cs.columbia.edu [mailto:kvmarm-
> bounces at lists.cs.columbia.edu] On Behalf Of Andre Przywara
> Sent: Friday, June 03, 2016 8:02 PM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>
> Cc: kvm at vger.kernel.org; Marc Zyngier <marc.zyngier@arm.com>;
> kvmarm at lists.cs.columbia.edu; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v4 00/12] KVM: arm64: GICv3 ITS emulation
> 
> Hi Bharat,
> 
> On 03/06/16 05:26, Bharat Bhushan wrote:
> > Hi Andre,
> >
> > We are looking for these patches but seems like these needed to
> > rebased/redesigned based on new GIC emulation changes. Can you give us
> > some sense on when this will be done?
> > Also do you know if someone is working on QEMU size changes for this,
> > if not then we can help on getting that done.
> 
> I just pushed a new version of the patches:
> https://lists.cs.columbia.edu/pipermail/kvmarm/2016-June/020482.html
> 
> I hope that answers your question about the kernel side of things.
> For QEMU I have no idea, maybe Christoffer or Peter would know.
> 
> Cheers,
> Andre.
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
