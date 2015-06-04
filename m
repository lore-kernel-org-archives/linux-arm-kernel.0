From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 4 Jun 2015 09:13:58 +0300
Subject: [PATCHv4 10/10] arm/dts: am57xx-beagle-x15.dts: add HDMI
In-Reply-To: <20150603171627.GU30984@atomide.com>
References: <1433139798-23450-1-git-send-email-tomi.valkeinen@ti.com>
 <1433139798-23450-11-git-send-email-tomi.valkeinen@ti.com>
 <20150601215115.GH30984@atomide.com> <556EE463.6000502@ti.com>
 <20150603154438.GS30984@atomide.com> <556F24E6.7040003@ti.com>
 <20150603161008.GT30984@atomide.com> <20150603171627.GU30984@atomide.com>
Message-ID: <556FECA6.6060408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/06/15 20:16, Tony Lindgren wrote:

>>>> OK, since there are no other merge conflicts that I'm aware of,
>>>> it's best that you merge the whole branch. I've acked the patches,
>>>> so for this one too:
>>>
>>> Ok, I can do that, but isn't this more linux-arm stuff? All the driver
>>> side code is already in the mainline.
>>
>> Yes but we're getting so late into merge window that I'd rather not
>> take it for v4.2 at this point. And it's all DSS related.
>>
>> Please make sure you get an ack for the drivers/clk/omap change from
>> Mike or Stephen though.
> 
> Naturally I mean "getting so close to the merge window" above :)

Thanks everyone. I've pushed this to fbdev for-next.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/b9e7fb6c/attachment.sig>
