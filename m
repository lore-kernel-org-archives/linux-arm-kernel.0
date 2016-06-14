From: b.reynal@virtualopensystems.com (Baptiste Reynal)
Date: Tue, 14 Jun 2016 17:29:39 +0200
Subject: [PATCH V7 0/9] vfio, platform: add ACPI support
In-Reply-To: <575EDA6C.9010806@codeaurora.org>
References: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
 <575EDA6C.9010806@codeaurora.org>
Message-ID: <CAN9JPjH6uSvGgY6aS5GDhxi5aTCfXhirFk7wNxvwTxXbV9jtzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

Although I don't have the hardware to test them, I reviewed your
patches and they look fine to me.

Regards,
Baptiste

On Mon, Jun 13, 2016 at 6:08 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Hi Baptiste,
>
> On 6/13/2016 12:26 AM, Sinan Kaya wrote:
>>
>> Sinan Kaya (9):
>>   vfio: platform: rename reset function
>>   vfio: platform: move reset call to a common function
>>   vfio: platform: determine reset capability
>>   vfio: platform: add support for ACPI probe
>>   vfio: platform: add extra debug info argument to call reset
>>   vfio: platform: call _RST method when using ACPI
>>   vfio, platform: make reset driver a requirement by default
>>   vfio: platform: check reset call return code during open
>>   vfio: platform: check reset call return code during release
>>
>>  drivers/vfio/platform/vfio_amba.c             |   5 +
>>  drivers/vfio/platform/vfio_platform.c         |   5 +
>>  drivers/vfio/platform/vfio_platform_common.c  | 195 +++++++++++++++++++++-----
>>  drivers/vfio/platform/vfio_platform_private.h |   8 +-
>>  4 files changed, 176 insertions(+), 37 deletions(-)
>>
> Cov and I exchanged some emails with Alex last week. I think
> there is a general expectation for you to review the series since
> you are the subsystem maintainer.
>
> I'm looking forward to hear your feedback on the series.
> Sinan
>
> --
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
