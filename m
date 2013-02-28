From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 28 Feb 2013 13:25:29 +0200
Subject: [PATCH 3/4] USB mxs-phy: use readl(),
 writel() instead of the _relaxed() versions
In-Reply-To: <1362048751-4061-4-git-send-email-mkl@pengutronix.de>
References: <1362048751-4061-1-git-send-email-mkl@pengutronix.de>
 <1362048751-4061-4-git-send-email-mkl@pengutronix.de>
Message-ID: <87sj4gwuhi.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> This patch converts the mxs-phy driver from readl_relaxed(), writel_relaxed()
> to the plain readl(), writel() functions, which are available on all platforms.
> This is done to enable compile time testing on non ARM platforms.
>
> Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

I think it was Felipe who reported this actually.

Regards,
--
Alex
