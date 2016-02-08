From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 8 Feb 2016 11:51:04 +0100
Subject: [PATCH v2 09/10] Documentation: devicetree: rockchip: Document
 Landingship
In-Reply-To: <6744409.i2u8076vm4@phil>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
 <1454897859-7601-10-git-send-email-afaerber@suse.de>
 <6744409.i2u8076vm4@phil>
Message-ID: <56B87318.9020007@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.02.2016 um 11:29 schrieb Heiko Stuebner:
> Am Montag, 8. Februar 2016, 03:17:38 schrieb Andreas F?rber:
>> Use "geekbuying,landingship" compatible string, plus those of GeekBox.
> 
> I do believe this would be better as geekbuying,geekbox-landingship . They 
> might reuse the landingship naming for future baseboards as well ;-)

Well, the question is: Is this MXM3 interface as generic as Qseven so
that it could be used as is for other modules (and baseboards from other
manufacturers could be used for the module)? Then my thought was
landingship as identifier for the baseboard and geekbox as identifier
for the contained module.

I agree that if this Landingship is specific to the GeekBox then
geekbox-landingship would be more appropriate. We could also do both.

Can you tell? Unfortunately I spot no real documentation of the MXM3
connector pins in the schematics we could compare, only an on-board
documentation of the three-row pins.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
