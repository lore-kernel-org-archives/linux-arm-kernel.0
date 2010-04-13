From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 13 Apr 2010 09:22:32 +0200
Subject: [PATCH 1/2] AT91 slow-clock suspend: don't wait when turning PLLs
	off
In-Reply-To: <20100412191006.GJ3048@n2100.arm.linux.org.uk>
References: <20100303213329.GA500@alarsen.net>
	<w2ocd73a99e1004061427t322f8d4cmecd708ad16580f00@mail.gmail.com>
	<20100412191006.GJ3048@n2100.arm.linux.org.uk>
Message-ID: <g2qcd73a99e1004130022ofa1da0br16ca99e96084e365@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Russell,

>> > AT91: when turning off the PLLs during suspend, don't wait for the lock flag
>> > to be set. Previously the code would always run into the loop limitation
>> > of 1000 iterations because the flag is never set when turning the PLLs off.
>> >
>> > Signed-off-by: Julien Langer <julien.langer@gmail.com>
>> > Signed-off-by: Anders Larsen <al@alarsen.net>
>> > Cc: Andrew Victor <avictor.za@gmail.com>
>> > Cc: Russell King <linux@arm.linux.org.uk>
>> ? ?Acked-by: Andrew Victor <linux@maxim.org.za>
>>
>>
> Thanks; I see your ack has been added to that patch. ?Should I assume that
> this is for -rc rather than -devel?

If it can still be merged for -rc, that would be great.
Otherwise the -devel branch is ok.


Regards,
  Andrew Victor
