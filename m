From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 15 May 2017 20:56:53 +0200
Subject: [PATCH v2 10/18] arm64: dts: meson-gxbb: Fix node order
In-Reply-To: <9c51a1dd-8d70-31f8-6fd7-f33861763e2d@baylibre.com>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-11-afaerber@suse.de>
 <9c51a1dd-8d70-31f8-6fd7-f33861763e2d@baylibre.com>
Message-ID: <6542edb0-8160-4963-ff59-b631d49e7b84@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.05.2017 um 10:17 schrieb Neil Armstrong:
> Like a previous attempt, I'm not OK with such rework since it will break bisect and add complexity for new patches handling.
> 
> The order is not alphabetically ordered, live with it.

No. I was the one to add GXBB, so you live with my preferences, don't
make my stuff ugly. What you do in your Nexboxes and reference boards is
a different question.

Also this certainly does not break bisect!

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
