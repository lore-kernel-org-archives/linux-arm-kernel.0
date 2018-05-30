From: eric@anholt.net (Eric Anholt)
Date: Wed, 30 May 2018 12:21:55 -0700
Subject: [PATCH V3 2/6] hwmon: Add support for RPi voltage sensor
In-Reply-To: <20180525193717.GA24967@roeck-us.net>
References: <1527276279-23876-1-git-send-email-stefan.wahren@i2se.com>
 <1527276279-23876-3-git-send-email-stefan.wahren@i2se.com>
 <20180525193717.GA24967@roeck-us.net>
Message-ID: <87lgc1ne3w.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck <linux@roeck-us.net> writes:

> On Fri, May 25, 2018 at 09:24:35PM +0200, Stefan Wahren wrote:
>> Currently there is no easy way to detect undervoltage conditions on a
>> remote Raspberry Pi. This hwmon driver retrieves the state of the
>> undervoltage sensor via mailbox interface. The handling based on
>> Noralf's modifications to the downstream firmware driver. In case of
>> an undervoltage condition only an entry is written to the kernel log.
>> 
>> CC: "Noralf Tr?nnes" <noralf@tronnes.org>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> ... assuming this will go through some arm tree.

That's fine with me, I can pull this whole set for 4.19.  Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/0d120acc/attachment.sig>
