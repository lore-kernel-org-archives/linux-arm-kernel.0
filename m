From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 May 2018 18:25:31 +0100
Subject: [PATCH RFC 3/6] hwmon: Add support for RPi voltage sensor
In-Reply-To: <20180517164320.GA30364@roeck-us.net>
References: <1526477827-10859-1-git-send-email-stefan.wahren@i2se.com>
 <1526477827-10859-4-git-send-email-stefan.wahren@i2se.com>
 <20180516182144.GB22705@roeck-us.net>
 <1560428919.21731.1526500741266@email.1und1.de>
 <20180517164320.GA30364@roeck-us.net>
Message-ID: <87sh6qdwj8.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck <linux@roeck-us.net> writes:

> On Wed, May 16, 2018 at 09:59:01PM +0200, Stefan Wahren wrote:
>> Hi Guenter,
>> 
>> > Guenter Roeck <linux@roeck-us.net> hat am 16. Mai 2018 um 20:21 geschrieben:
>> > 
>> > 
>> > On Wed, May 16, 2018 at 03:37:04PM +0200, Stefan Wahren wrote:
>> > > Currently there is no easy way to detect under-voltage conditions on a remote
>> > > Raspberry Pi. This hwmon driver retrieves the state of the under-voltage sensor
>> > > via mailbox interface. The handling based on Noralf's modifications to the
>> > > downstream firmware driver. In case of an under-voltage condition only an entry
>> > > is written to the kernel log.
>> > > 
>> > 
>> > My major concern is how this is displayed with the 'sensors' command.
>> > Can you test and report ?
>> 
>> I get the following output:
>> rpi_volt-isa-0000
>> Adapter: ISA adapter
>> in0:              N/A  
>> 
> Ok, that works.

Thanks for the quick review on this, Guenter!  This driver is going to
help save a lot of people debugging time on rpis in the upstream kernel.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/f9ce6988/attachment.sig>
