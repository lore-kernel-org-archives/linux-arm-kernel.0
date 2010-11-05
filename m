From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Nov 2010 12:49:16 +0100
Subject: [PATCH 4/7] ARM i.MX irq: Allow runtime decision between AVIC
	and TZIC
In-Reply-To: <1288950371-1552-5-git-send-email-s.hauer@pengutronix.de>
References: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
	<1288950371-1552-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20101105114916.GK16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Nov 05, 2010 at 10:46:08AM +0100, Sascha Hauer wrote:
> As we are on a path to support more different i.MX SoCs in a single
> binary we have to able to support both AVIC and TZIC in a single
> binary. This patch only introduces overhead when both controllers
> are needed.
During my lunch break I remembered this patch:

	http://article.gmane.org/gmane.linux.ports.arm.kernel/84809

With that supporting both irq controllers should be a bit nicer.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
