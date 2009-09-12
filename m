From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 12 Sep 2009 15:48:13 +0200
Subject: [PATCH v2 RESEND 2/2] ARM: copy_page.S: take into account the
	size of the cache line
In-Reply-To: <306c1f489fbdca8d52676e8a40ded02607f76096.1252770642.git.kirill@shutemov.name>
References: <a9bd121a726831bc30f4ec04235eda667e602615.1252770642.git.kirill@shutemov.name>
	<306c1f489fbdca8d52676e8a40ded02607f76096.1252770642.git.kirill@shutemov.name>
Message-ID: <20090912134813.GA32514@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Just two minor nitpicks:

> V2:
>   - include <asm/cahce.h>
s/cahce/cache/
>   - remove unnecessary parens and fix style
s/parens/parenthesis/

Note I didn't look at the patch.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
