From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Mar 2012 09:11:31 -0700
Subject: [PATCH 03/17] ARM: mark const init data with __initconst
 instead of __initdata
In-Reply-To: <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120329211131.GA31250@pengutronix.de>
 <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120330161130.GA8240@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [120329 14:16]:
> As long as there is no other non-const variable marked __initdata in the
> same compilation unit it doesn't hurt. If there were one however
> compilation would fail with
> 
> 	error: $variablename causes a section type conflict
> 
> because a section containing const variables is marked read only and so
> cannot contain non-const variables.

Acked-by: Tony Lindgren <tony@atomide.com>
