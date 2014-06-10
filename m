From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 10 Jun 2014 15:49:41 +0200
Subject: [RESEND2 PATCH v4 2/2] i2c: sunxi: add P2WI (Push/Pull 2 Wire
 Interface) controller support
In-Reply-To: <5396C848.8020701@pcserviceselectronics.co.uk>
References: <1401785392-26602-1-git-send-email-boris.brezillon@free-electrons.com>
 <1401785392-26602-3-git-send-email-boris.brezillon@free-electrons.com>
 <20140610083850.GB2620@katana> <5396C848.8020701@pcserviceselectronics.co.uk>
Message-ID: <53970CF5.50701@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

On 10/06/2014 10:56, Paul Carpenter wrote:
> Wolfram Sang wrote:
>> On Tue, Jun 03, 2014 at 10:49:52AM +0200, Boris BREZILLON wrote:
>>> The P2WI looks like an SMBus controller which only supports byte data
>>> transfers. But, it differs from standard SMBus protocol on several
>>> aspects:
>>> - it supports only one slave device, and thus drop the address field
>>> - it adds a parity bit every 8bits of data
>>> - only one read access is required to read a byte (instead of a read
>>>   followed by a write access in standard SMBus protocol)
>
> Minor quibble should be
> "(instead of a write followed by a read access in standard SMBus
>   protocol)"
>

Fixed.

Thanks for pointing this out.

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
