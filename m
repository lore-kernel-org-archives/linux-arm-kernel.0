From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 16:07:07 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120515170020.23c68cac@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB26E4B.4020609@codethink.co.uk> <20120515170020.23c68cac@skate>
Message-ID: <4FB2711B.8080602@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 16:00, Thomas Petazzoni wrote:
> Le Tue, 15 May 2012 15:55:07 +0100,
> Ben Dooks<ben.dooks@codethink.co.uk>  a ?crit :
>
>>> This preliminary support only includes the necessary code for timer
>>> and IRQ support, the serial controller is a standard
>>> 16550-compatible one. The diffstat looks like:
>>
>> FYI, built and tested on our system here and it gets to
>> printing the sched_clock line and getting no further.
>>
>> I will have a debug.
>
> Hum, strange. On which platform exactly?

Cogent CS1726, using MV78460 (A0)

> I've built from scratch a kernel image this morning and boot tested it
> on both the DB-78460-BP (Armada XP) and DB-88F6710-BP (Armada 370) this
> morning, and it was working.
>
>> The only comment so far other than the review issues is that
>> we needed to enable CONFIG_HIGMEM to get>780MiB of memory
>> as this system comes with 2048MiB as standard.
>
> Good point. Will do.

I'm guessing it'll be a useful default, but not a necessity.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
