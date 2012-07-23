From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 23 Jul 2012 08:32:13 -0700
Subject: [PATCH 19/25] of: add const to struct *of_device_id.data
In-Reply-To: <1343034810-3386-20-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-20-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120723153213.GC19571@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 11:13:24AM +0200, Uwe Kleine-K?nig wrote:
> Drivers should never need to modify the data of a device id. So it can
> be const which in turn allows more consts in the driver.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
