From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 25 Apr 2014 17:20:19 +0300
Subject: [PATCH 11/23] ARM: dts: omap5-uevm.dts: add tca6424a
In-Reply-To: <53594189.1090508@cogentembedded.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
 <1398334639-14172-12-git-send-email-tomi.valkeinen@ti.com>
 <53591669.7060502@cogentembedded.com> <5359209F.7000308@ti.com>
 <53594189.1090508@cogentembedded.com>
Message-ID: <535A6F23.1070409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/14 19:53, Sergei Shtylyov wrote:

>> Right. I wonder what the name should be... "gpio" is out, as the name
>> should be more specific.
> 
>    No, it's not out. The name should be "gpio at 22", I think it would be
> unique.
> 
>> We already have gpio1-8, which are the gpio
>> banks from the SoC.
> 
>    I don't understand why you are indexing the names while you probably
> have the address part after @ that makes them unique already.

Ah sorry for the confusion, I misunderstood. I was talking about the
label, not the name, of the node.

So the labels for the gpio banks are 'gpio2' etc. The names are
'gpio at 123456' etc. And yes, here the name should be 'gpio at 22' as you said.

I didn't see any rules about the labels in the ePARP doc, so I guess
'tca6424a' would be a valid one. Maybe not a good one, though,
especially if there are multiple tca6424a chips on the board (I need to
check).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/48f2728c/attachment.sig>
