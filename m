From: mbrugger@suse.com (Matthias Brugger)
Date: Tue, 1 Mar 2016 12:42:12 +0100
Subject: [PATCH 7/8] ARM64: dts: amlogic: Extend GXBaby GIC node
In-Reply-To: <56D57A7F.5020806@suse.de>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-8-git-send-email-afaerber@suse.de>
 <56D57673.8030702@arm.com> <56D57A7F.5020806@suse.de>
Message-ID: <56D58014.30701@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/03/16 12:18, Andreas F?rber wrote:
> Hi Andre,
>
> Am 01.03.2016 um 12:01 schrieb Andre Przywara:
>> On 29/02/16 23:44, Andreas F?rber wrote:
>>> Add GICH and GICV resources for HYP mode - guess based on other vendors.
>>
>> Do you know if the firmware allows the kernel to be entered in EL2
>> (which is the arm64 name for HYP)?
>> So can we run kvm?
>> If you have a booted kernel, can you grep for "EL2" and "kvm" in the dmesg?
>
> I do not have a rootfs yet (MMC v5 patches by Carlo are still waiting
> for review), but with this change the KVM driver initializes okay - the
> purpose of this patch!
>
>> Also you should merge this patch into 3/8, same for 8/8.
>
> If people confirm this is generally or specifically for this SoC correct
> then sure. So far 3/8 seems a safe subset for lack of public documentation.
>

Yes, this is generally correct. Actually without 8/8 you won't be able 
to run an initramfs.

Regards,
Matthias
