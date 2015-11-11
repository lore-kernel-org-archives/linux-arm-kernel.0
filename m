From: balbi@ti.com (Felipe Balbi)
Date: Wed, 11 Nov 2015 13:31:54 -0600
Subject: [PATCH] ARM: OMAP: DRA7: hwmod: Add data for McASP3
In-Reply-To: <56439641.6070901@ti.com>
References: <1447261631-26362-1-git-send-email-balbi@ti.com>
 <56439641.6070901@ti.com>
Message-ID: <877flos579.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> Felipe,
>
> On 11/11/2015 07:07 PM, Felipe Balbi wrote:
>> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> 
>> McASP3 is used by default on DRA7x based boards for audio.
>
> While this patch works, it is not the correct one(s) to apply.
> https://lkml.org/lkml/2015/10/30/91
> is the series which should have been applied to 4.4.
>
> Paul acked the series, but for some reason it missed the initial ARM
> pull for 4.4

okay, cool. Hopefully Tony will apply shortly.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151111/c3d2dbf7/attachment.sig>
