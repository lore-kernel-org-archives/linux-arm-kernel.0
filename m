From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Sat, 26 Jul 2014 21:03:56 +0200
Subject: [RESEND][PATCHv2 0/3] Fix for buggy u-boot memory banks
In-Reply-To: <1405443816-29917-1-git-send-email-lauraa@codeaurora.org>
References: <1405443816-29917-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <53D3FB9C.9080908@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

Am 15.07.2014 19:03, schrieb Laura Abbott:
> This is a resend of the series to fix the uboot bug exposed by the removal
> of meminfo. I haven't gotten any acks though.
> 
> Please help with review/acks. Grant/Rob, I'd still like this to go through
> the devicetree tree if possible.

Sorry for the delay in testing.

With this v2 applied on top of kgene's for-next branch (plus
https://patchwork.kernel.org/patch/4297431/ as build fix) I get:

[    9.699985] Unhandled fault: asynchronous external abort (0x211) at
0x00000000

Same for v1 that had worked okay before, so it's not your series, but it
may explain why you haven't heard on v2 from the others yet.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
