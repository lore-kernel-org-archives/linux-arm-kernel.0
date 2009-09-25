From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 25 Sep 2009 10:27:14 +0200
Subject: [PATCH] mach-iop32x/ Add nec ns-50 / ApplianceWare sanmina support
In-Reply-To: <20090924215915.GA27322@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu\, 24 Sep 2009 22\:59\:15 +0100")
References: <87ocr6uyhx.fsf@lechat.rtp-net.org>
	<e9c3a7c20908301646w3cc8199dg392b95faad5616de@mail.gmail.com>
	<87hbut7890.fsf@lechat.rtp-net.org>
	<20090924215915.GA27322@n2100.arm.linux.org.uk>
Message-ID: <87fxab5t0d.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

Hi,

> On Wed, Sep 23, 2009 at 09:48:11PM +0200, Arnaud Patard wrote:
>> +static struct plat_serial8250_port sanmina_serial_port[] = {
>> +	{
>> +		.mapbase	= IQ31244_UART,
>> +		.membase	= (char *)IQ31244_UART,
>
> This can't be right.

It is kind of right and it's working fine. You've made the same remark
when I've submitted the em7210 support :) (fwiw, the sanmina.c file is
based on my em7210.c code) See
http://lists.arm.linux.org.uk/lurker/message/20070715.164059.ac9fbe0a.en.html


Arnaud
