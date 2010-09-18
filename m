From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 18 Sep 2010 16:28:57 +0200
Subject: [PATCH] at91: drop at91x40 support
In-Reply-To: <4C94875B.3060200@snapgear.com>
References: <1284790974-11143-1-git-send-email-plagnioj@jcrosoft.com>
	<4C94875B.3060200@snapgear.com>
Message-ID: <20100918142857.GA12003@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:33 Sat 18 Sep     , Greg Ungerer wrote:
> On 18/09/10 16:22, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >as it's broken for releases and no one care about it
> >
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> >Cc: Andrew Victor<linux@maxim.org.za>
> >Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> >Cc: Greg Ungerer<gerg@snapgear.com>
> 
> NAK, I care. I sent a fix to this very list about a week ago
> to fix the current compile problem.
sorry but not see it
and I see it failled to build for at least 4 releases and
no debug-macro.S for years
since what 4 or 5 years we just have the timer and irq

do you have plan to update it?

or I do not see the current implementation very usefull so I still prefer to
drop it

Best Regards,
J.
