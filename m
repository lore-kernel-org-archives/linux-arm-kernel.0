From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Oct 2011 18:58:55 -0600
Subject: [PATCH] gpio: exynos4: Add device tree support
In-Reply-To: <069c01cc88e3$92f86d90$b8e948b0$%kim@samsung.com>
References: <1318320974-9879-1-git-send-email-thomas.abraham@linaro.org>
	<069c01cc88e3$92f86d90$b8e948b0$%kim@samsung.com>
Message-ID: <20111013005855.GJ14042@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 10:33:48PM +0900, Kukjin Kim wrote:
> Thomas Abraham wrote:
> > 
> > As gpio chips get registered, a device tree node which represents the
> > gpio chip is searched and attached to it. A translate function is also
> > provided to convert the gpio specifier into actual platform settings
> > for pin function selection, pull up/down and driver strength settings.
> > 
> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> 
> Hi Thomas,
> 
> You got some comments from Rob, so could you please address from him?
> Others, looks ok to me.
> 
> And I need to get the ack from Grant to upstream via Samsung tree for
> upcoming merge window.
> Grant, is this ok for you?

Yes, go ahead and merge it with my:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
