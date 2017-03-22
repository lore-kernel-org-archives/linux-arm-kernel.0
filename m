From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 22 Mar 2017 10:13:00 -0500
Subject: [PATCH] [v2][for 4.11]tty: acpi/spcr: QDF2400 E44 checks for
 wrong OEM revision
In-Reply-To: <CAOZdJXUVz8w2tQdgQ1CyQC9XZL=Gig5kaSEb3b+3Yjap0ExfGg@mail.gmail.com>
References: <1488313833-12430-1-git-send-email-timur@codeaurora.org>
 <CAOZdJXUVz8w2tQdgQ1CyQC9XZL=Gig5kaSEb3b+3Yjap0ExfGg@mail.gmail.com>
Message-ID: <CAOZdJXW6k=fwaD96dPSikK6kntbKFuhypALG8YGbcWcBcRcLiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 12, 2017 at 11:19 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On Tue, Feb 28, 2017 at 2:30 PM, Timur Tabi <timur@codeaurora.org> wrote:
>> For Qualcomm Technologies QDF2400 SOCs that are affected by erratum E44,
>> the ACPI oem_revision field is actually set to 1, not 0.
>>
>> Fixes: d8a4995bcea1 ("tty: pl011: Work around QDF2400 E44 stuck BUSY bit")
>>
>> Tested-by: Manoj Iyer <manoj.iyer@canonical.com>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>
> Greg, this is a critical fix for our platform.  Can you please pick it
> up for 4.11-rc3?  Thank you.

Ok, how about 4.11-rc4?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
