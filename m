From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 3 Jun 2015 19:01:42 +0300
Subject: [PATCHv4 10/10] arm/dts: am57xx-beagle-x15.dts: add HDMI
In-Reply-To: <20150603154438.GS30984@atomide.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
 <1433139798-23450-11-git-send-email-tomi.valkeinen@ti.com>
 <20150601215115.GH30984@atomide.com> <556EE463.6000502@ti.com>
 <20150603154438.GS30984@atomide.com>
Message-ID: <556F24E6.7040003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/06/15 18:44, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [150603 04:28]:
>>
>>
>> On 02/06/15 00:51, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [150531 23:25]:
>>>> AM57xx Beagle X15 has a HDMI output. This patch adds the device tree
>>>> nodes required for HDMI.
>>>
>>> This one does not seem to apply to linux next, did not look
>>> further where it conflicts.
>>
>> Looks like the change was also in -rc6. I've rebased my patches on -rc6,
>> and added the acks:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git dra7-dss-arch
> 
> OK, since there are no other merge conflicts that I'm aware of,
> it's best that you merge the whole branch. I've acked the patches,
> so for this one too:

Ok, I can do that, but isn't this more linux-arm stuff? All the driver
side code is already in the mainline.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/a67db133/attachment.sig>
