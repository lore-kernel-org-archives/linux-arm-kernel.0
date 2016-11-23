From: uwe@kleine-koenig.org (=?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=)
Date: Wed, 23 Nov 2016 19:36:53 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161123145916.GL14947@lunn.ch>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
 <20161114201640.rr32iyjf5a53v33t@perseus.defre.kleine-koenig.org>
 <20161114202832.GG24546@lunn.ch> <1479586147.10840.0@smtp.gmail.com>
 <20161120203037.pd5mhqyjeotileve@perseus.defre.kleine-koenig.org>
 <1479851991.26813.2@smtp.gmail.com> <20161123145916.GL14947@lunn.ch>
Message-ID: <09b7d4a1-40e5-7aee-d777-9bd9f9b434b4@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On 11/23/2016 03:59 PM, Andrew Lunn wrote:
>>> CZ11NIC12 is indicated on my board.
>>
>> :-( Well, this board version has wrongly matched length of some
>> differential pairs, IRQ from 88E1514 is connected differently, there
>> are slight differences in power supplies and (if I am not mistaken)
>> something changed in RTC support circuitry. It looks like a huge
>> mistake on our side.
> 
> Hi Tomas
> 
> Would these problems also explain why the Ethernet links to the switch
> don't work? Maybe the differential pairs?

no this is not the problem. When booting the OpenWRT based system I can
communicate with the device via the switch. (Didn't test deeply, but my
Laptop got a dhcp lease from the Turris Omnia and I can ping it.) But
this convinces me, that the hardware is good enough.

If you have any ideas what I can try to make the switch work or help to
diagnose the problem, just let me know.

Best regards
Uwe

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161123/3b35fee8/attachment.sig>
