From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 14 Sep 2009 18:24:57 +0200
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <94a0d4530909140906v72865664w3976766e57bf2aa3@mail.gmail.com>
References: <20090913230008.GC30169@n2100.arm.linux.org.uk>
	<20090914002100.GD30621@shareable.org>
	<20090914081001.GB14519@n2100.arm.linux.org.uk>
	<94a0d4530909140558nd8d2c47lc9954563c80a574f@mail.gmail.com>
	<20090914140059.GC21580@n2100.arm.linux.org.uk>
	<94a0d4530909140738t7e4d646r134cfd884da21348@mail.gmail.com>
	<20090914144028.GG21580@n2100.arm.linux.org.uk>
	<94a0d4530909140814w36f7f5f0td2c25db07fbd4e57@mail.gmail.com>
	<20090914153616.GD3164@pengutronix.de>
	<94a0d4530909140906v72865664w3976766e57bf2aa3@mail.gmail.com>
Message-ID: <20090914162457.GE3164@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The minority that would make use of this code is theoretical, and
> these users by definition know they need this code, therefore, if the
> code is not there, they'll notice,

I'm not sure everyone knows in advance what is going on. I imagine the case
where something is inadeqaute, one starts looking at the code and _after_
reading the #if 0-block, understands the problem and realizes that the block is
needed in this rare case. So, it's like some kind of documentation. This is why
I'd still favour the comment; if there is a chance for such a patch, I'd make
it BTW.

> If it turns out nobody complains about removing this code you would
> have made the linux kernel 16 lines cleaner for free.

I'd think we lose a bit of information. (Yeah, it is in the history, but harder
to find there.)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090914/b48967cf/attachment.sig>
