From: dann.frazier@canonical.com (dann frazier)
Date: Tue, 28 Feb 2017 13:25:19 -0700
Subject: [PATCH] tty: acpi/spcr: QDF2400 E44 checks for wrong OEM revision
In-Reply-To: <ad478756-9b4d-79a0-1da3-a2265ba7ec49@codeaurora.org>
References: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
 <CALdTtnsbh3fZF+Ci1JmQ=Awod5QPWB4+gTRWx0u9=xyaLfhNmw@mail.gmail.com>
 <ad478756-9b4d-79a0-1da3-a2265ba7ec49@codeaurora.org>
Message-ID: <CALdTtnsRnjqXZGh=EfVtg0wjFs+hcq5Z0Qy0Tqh7ZOGhbUaBww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 1:23 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On 02/28/2017 02:19 PM, dann frazier wrote:
>>
>> On Mon, Feb 27, 2017 at 8:24 PM, Timur Tabi <timur@codeaurora.org> wrote:
>>>
>>> For Qualcomm Technologies QDF2400 SOCs that are affected by
>>> erratum E44, the ACPI oem_revision field is actually set to 1,
>>> not 0.
>>
>>
>> Should this 'Fixes: d8a4995bcea1 ("PCI: Add ACS quirk for Qualcomm
>> QDF2400 and QDF2432")' ?
>
>
> Fixes: d8a4995bcea1 ("tty: pl011: Work around QDF2400 E44 stuck BUSY bit")

oops.. right.  Pulled the long line from my git --grep QDF2400 :(

  -dann

> I will post a v2.
>
>
> --
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
