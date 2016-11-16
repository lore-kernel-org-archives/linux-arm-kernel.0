From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Wed, 16 Nov 2016 20:24:16 +0530
Subject: [PATCH v8 0/7] arm/arm64: vgic: Implement API for vGICv3 live
 migration
In-Reply-To: <20161116114722.GB3811@cbox>
References: <1478258013-6669-1-git-send-email-vijay.kilari@gmail.com>
 <20161116114722.GB3811@cbox>
Message-ID: <CALicx6t=0sRYG1jn_=hqod+Kca9-8fWbtwL_-HXE3HvrA_h7PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 5:17 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Fri, Nov 04, 2016 at 04:43:26PM +0530, vijay.kilari at gmail.com wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>
>> This patchset adds API for saving and restoring
>> of VGICv3 registers to support live migration with new vgic feature.
>> This API definition is as per version of VGICv3 specification
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445611.html
>>
>> The patch 3 & 4 are picked from the Pavel's previous implementation.
>> http://www.spinics.net/lists/kvm/msg122040.html
>
> Do we have QEMU/kvmtool patches somewhere at this point so that I can
> test this?

I will send you next revision of QEMU patches tomorrow.

>
> Thanks,
> -Christoffer
