From: greg@kroah.com (Greg KH)
Date: Thu, 29 Jun 2017 17:12:00 +0200
Subject: [PATCH v3 0/9] Add and make use of a common rs485 device tree
 parsing function
In-Reply-To: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170629151200.GA16362@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 11:07:54AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this is v3 of the series that targets to consolidate parsing the rs485 specific
> dt properties in a single place.

This patch breaks the build, and not all of them applied properly :(

Please be more careful when you fix this up and resend...

thanks,

greg k-h
