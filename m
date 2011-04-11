From: gregkh@suse.de (Greg KH)
Date: Mon, 11 Apr 2011 12:07:53 -0700
Subject: [PATCH 1/5] driver core/platform_device_add_data: set
	platform_data to NULL if !data
In-Reply-To: <20110411185035.GA7771@pengutronix.de>
References: <20110301153438.GB15633@suse.de>
	<1302081865-2962-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110411185035.GA7771@pengutronix.de>
Message-ID: <20110411190753.GB21355@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 08:50:35PM +0200, Uwe Kleine-K?nig wrote:
> Hi Greg,
> 
> do you care for the Reviewed-by: tag from Viresh or should I resend?

Feel free to resend, I'm still working through my patch backlog for
being away for a few weeks...

thanks,

greg k-h
