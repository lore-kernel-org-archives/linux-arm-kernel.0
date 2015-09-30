From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 30 Sep 2015 08:10:02 +0200
Subject: [PATCH 1/1] Disable CONFIG_UACCESS_WITH_MEMCPY in Atmel config.
In-Reply-To: <1443565968-7012-1-git-send-email-jc@eclis.ch>
References: <1443565968-7012-1-git-send-email-jc@eclis.ch>
Message-ID: <20150930061002.GI3982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Sep 30, 2015 at 12:32:48AM +0200, jc at eclis.ch wrote:
> From: Jean-Christian de Rivaz <jc@eclis.ch>
> 
> According to Russell King:
> In any case, unless you have a Marvell platform, you should have this
> disabled - it provides a performance boost for Marvell platforms, but
> degrades performance everywhere else.  Please ensure that you disable
> CONFIG_UACCESS_WITH_MEMCPY.
> 
> Signed-off-by: Jean-Christian de Rivaz <jc@eclis.ch>
the change is fine now. Feel free to add my Ack also if you do another
round to improve the changelog.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
