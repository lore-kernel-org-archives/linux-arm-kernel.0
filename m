From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 28 Feb 2014 10:49:26 +0200
Subject: [PATCH 1/8] clk: divider: fix rate calculation for fractional
 rates
In-Reply-To: <20140227022524.12081.32368@quantum>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
 <1392285846-13199-2-git-send-email-tomi.valkeinen@ti.com>
 <52FE1DF2.2040707@ti.com> <20140227022524.12081.32368@quantum>
Message-ID: <53104D96.5040704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/14 04:25, Mike Turquette wrote:

>> Basically the patch looks good to me, but it might be good to have a 
>> testing round of sort with this. It can potentially cause regressions on 
>> multiple boards if the drivers happen to rely on the "broken" clock 
>> rates. Same for patch #2 which is a copy paste of this one, but only 
>> impacts TI boards.
> 
> Agreed. I've taken patches #1 & #2 into clk-next. Let's let them stew in
> -next for a while and see if anyone's board catches on fire.

Thanks. I understand there's a possibility this could break some other
driver. I still wish we could get this to 3.14, as this would fix OMAP
display subsystem.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/ffb9e296/attachment.sig>
