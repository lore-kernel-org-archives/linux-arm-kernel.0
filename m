From: eric@anholt.net (Eric Anholt)
Date: Mon, 15 May 2017 12:03:29 -0700
Subject: [PATCH] clk: bcm2835: Correct the prediv logic
In-Reply-To: <1373231207.445862.1494870459462@email.1und1.de>
References: <20170515173504.11337-1-eric@anholt.net>
 <1373231207.445862.1494870459462@email.1und1.de>
Message-ID: <87bmqundry.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 15. Mai 2017 um 19:35 geschrieben:
>> 
>> 
>> From: Phil Elwell <phil@raspberrypi.org>
>> 
>> If a clock has the prediv flag set, both the integer and fractional
>> parts must be scaled when calculating the resulting frequency.
>> 
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>> 
>> While this is a bugfix, I haven't put a "Fixes:" line in here to get
>> it automatically backported to stable.  
>
> sorry, i can't follow. How should this happen without "Fixes: "?

I didn't want it to be backported to stable, because of the risk.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170515/803ae7fe/attachment.sig>
