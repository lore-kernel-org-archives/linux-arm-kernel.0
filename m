From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 20 Apr 2010 17:21:05 +0800
Subject: [PATCH V2] mach-pxa/viper: Fix timeout usage for I2C
In-Reply-To: <201004201040.00739.marek.vasut@gmail.com>
References: <20100412213235.1688dda8@hyperion.delvare>
	<1271591309-22567-1-git-send-email-w.sang@pengutronix.de>
	<8d2bff4f5c4178f89e410edc702cd18f@localhost>
	<201004201040.00739.marek.vasut@gmail.com>
Message-ID: <p2kf17812d71004200221gf81c664dradf3baf1137a6b1a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 20, 2010 at 4:40 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne ?t 20. dubna 2010 10:27:00 Marc Zyngier napsal(a):
>> On Sun, 18 Apr 2010 13:48:29 +0200, Wolfram Sang <w.sang@pengutronix.de>
>>
>> wrote:
>> > The timeout value is in jiffies, so it should be using HZ, not a plain
>> > number. Assume with HZ=100 '100' means 1s here and adapt accordingly.
>> >
>> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>> > Cc: Eric Miao <eric.y.miao@gmail.com>
>> > Cc: Russell King <linux@arm.linux.org.uk>
>> > Cc: Marc Zyngier <maz@misterjones.org>
>> > Cc: Paul Shen <paul.shen@marvell.com>
>> > Cc: Mike Rapoport <mike@compulab.co.il>
>> > Cc: Jean Delvare <khali@linux-fr.org>
>>
>> Acked-by: Marc Zyngier <maz@misterjones.org>
>>
>> Eric, can you merge this directly via your -devel branch?
>>
>> Thanks,
>>
>> ? ? ? ? M.
>
> And possibly updating your git tree? There are a few patches in -next that will
> need it's arm counterpart.
>

Merged and updated.
