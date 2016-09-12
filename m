From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 12 Sep 2016 22:14:51 +0530
Subject: [PATCH v4 0/5] arm/arm64: vgic-new: Implement API for vGICv3 live
 migration
In-Reply-To: <57D6AA83.6060208@arm.com>
References: <1473510138-4719-1-git-send-email-vijay.kilari@gmail.com>
 <57D6AA83.6060208@arm.com>
Message-ID: <CALicx6sqSf1yS61-tOHCX58oQC7UT+H-R2K6ztH+p=9KZCX+3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 6:45 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 10/09/16 13:22, vijay.kilari at gmail.com wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>
>> This patchset adds API for saving and restoring
>> of VGICv3 registers to support live migration with new vgic feature.
>> This API definition is as per version of VGICv3 specification
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445611.html
>>
>> Compatible live migration QEMU patches will be sent later.
>
> Could you please point to the QEMU patches as well? I need to be able to
> test the this infrastructure.

I just sent you corresponding QEMU patches.

Thanks
Vijay
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
