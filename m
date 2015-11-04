From: hgkr.klein@gmail.com (Helmut Klein)
Date: Wed, 4 Nov 2015 12:29:45 +0100
Subject: wrong value in kirkwood-ts219.dtsi
In-Reply-To: <20151103203628.GA25118@lunn.ch>
References: <56390400.5070408@gmail.com> <20151103203628.GA25118@lunn.ch>
Message-ID: <5639EC29.8010604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Andrew,

here is the patch (created with diff -up and then compressed with xz)

regards
Helmut

On 03.11.2015 21:36, Andrew Lunn wrote:
> On Tue, Nov 03, 2015 at 07:59:12PM +0100, Helmut Klein wrote:
>> Hallo,
>>
>> the line "reg = <0x12000 0x100>;" in the section "poweroff at 12100" is
>> not correct
>>
>> The base address of uart1, which is connected to the pic controller
>> is 0x12100 and not 0x12000
>
> Yes, it is wrong.
>
> Do you want to produce a proper patch for this?
>
> Thanks
> 	Andrew
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-kirkwood-ts219.dtsi.xz
Type: application/x-xz
Size: 288 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/2fd74ab2/attachment-0001.xz>
