From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 17 Dec 2015 09:55:30 -0600
Subject: [PATCH] tty: amba-pl011: add support for 32-bit register access
 for earlycon
In-Reply-To: <20151213060643.GA30667@kroah.com>
References: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
 <20151213060643.GA30667@kroah.com>
Message-ID: <CAOZdJXVz5Bm2-XBNjoU6uh=i2E0Mq915entU+rz-MqD8F4C=xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 13, 2015 at 12:06 AM, Greg Kroah-Hartman <greg@kroah.com> wrote:

>> Example:
>>
>>       earlycon=pl011,mmio32,0x3ced1000
>>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>> ---
>>
>> This patch applies on top of Russell's 12-part amba-pl011.c patchset.
>
> Which I didn't apply, so can you resend this after he resends his?

I see that some of Russell's patches are now in tty-next.  Does that
make them official?  There was some disagreement about the usage of
access_32b vs uap->port.iotype for determining whether we need 32-bit
accessors or not.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
