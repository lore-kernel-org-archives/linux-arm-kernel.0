From: b32955@freescale.com (Huang Shijie)
Date: Wed, 10 Jul 2013 10:58:26 +0800
Subject: [PATCH] of: match the compatible in the order set by the dts file
In-Reply-To: <CAL_JsqL4ABJCQXveSAMZKOiHwJi=w8zFYjg3DV7kqEEcCXQJcw@mail.gmail.com>
References: <1373013818-11365-1-git-send-email-b32955@freescale.com>	<20130709070541.GQ516@pengutronix.de>	<51DBBFDA.70302@freescale.com>	<20130709075124.GR516@pengutronix.de>	<51DBC58D.90002@freescale.com>
 <CAL_JsqL4ABJCQXveSAMZKOiHwJi=w8zFYjg3DV7kqEEcCXQJcw@mail.gmail.com>
Message-ID: <51DCCDD2.707@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?09? 20:03, Rob Herring ??:
> the same and that is the assumption. Matching is not just based on
> compatible properties and your patch does not handle the other cases.
Could you show a example of "the other cases"?

After this patch,

[1] the matching will first check the @match->type and @match->name,
if we can match the @match->type or @match->name, return the match
immediately.

[2] If [1] fails, we will check the compatible properties.



thanks
Huang Shijie
