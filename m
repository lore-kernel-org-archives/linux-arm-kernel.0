From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 13 Jun 2010 18:53:38 +0800
Subject: [PATCH 1/2] ISL6271A voltage regulator support.
In-Reply-To: <201006071654.51324.marek.vasut@gmail.com>
References: <1275887908-22285-1-git-send-email-marek.vasut@gmail.com>
	<20100607114856.GD5993@sirena.org.uk>
	<201006071654.51324.marek.vasut@gmail.com>
Message-ID: <AANLkTilhU0XW7fo4yOT7v6AXc0UNmlGGiMs7ilGXQJii@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 7, 2010 at 10:54 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne Po 7. ?ervna 2010 13:48:56 Mark Brown napsal(a):
>> On Mon, Jun 07, 2010 at 07:18:27AM +0200, Marek Vasut wrote:
>> > This device is very simple, it supports only one LDO. This single LDO is
>> > programmed over I2C to 16 possible voltages.
>>
>> Marek, you really should know to CC patches to maintainers by now. ?This
>> is not CCed to myself, Liam or lkml.
>

Indeed Marek, please Cc Liam and Mark Brown for any sound/regulator stuffs.

And I am a bit confused about this as well, since PATCH 1/2 and PATCH 2/2
doesn't seem to be related. Next time, I'd suggest such two be
individual patches.
