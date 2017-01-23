From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 23 Jan 2017 15:54:51 +0530
Subject: [PATCH v10 0/8] arm/arm64: vgic: Implement API for vGICv3 live
 migration
In-Reply-To: <20170120195915.GK13531@cbox>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
 <20170120195915.GK13531@cbox>
Message-ID: <CALicx6sCdPdS97Lcsfr0BGyW21FXBVfMyWPRDtNXAcFLXp29Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 21, 2017 at 1:29 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> Hi Vijaya,
>
> On Thu, Dec 01, 2016 at 12:39:39PM +0530, vijay.kilari at gmail.com wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>
>> This patchset adds API for saving and restoring
>> of VGICv3 registers to support live migration with new vgic feature.
>> This API definition is as per version of VGICv3 specification
>> Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>>
>> The patch 3 & 4 are picked from the Pavel's previous implementation.
>> http://www.spinics.net/lists/kvm/msg122040.html
>>
>> NOTE: Only compilation tested for AArch32. No hardware to test.
>>
>
> I'm mostly happy with this series at this point, and everything beyond
> the ABI discussion can be fixed later if we should spot anything.
>
> Assuming we can agree on the API for the level_info shortly, can you
> address the other comments in the series and reabse on v4.10-rc4 (or rc5
> if that's out when you get there) and send out a new version that we can
> queue?

OK.

Regards
Vijay
