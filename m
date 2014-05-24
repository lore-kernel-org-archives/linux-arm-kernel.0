From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 24 May 2014 13:05:00 -0700
Subject: [PATCH] ARM: imx: introduce function imx_free_mx3_camera
In-Reply-To: <20140524152200.GA4666@lianli>
References: <1400781080-6117-1-git-send-email-emilgoode@gmail.com>
 <20140522181024.GA20155@pengutronix.de>
 <20140524152200.GA4666@lianli>
Message-ID: <20140524200500.GB1023@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 24, 2014 at 05:22:00PM +0200, Emil Goode wrote:
> Hello Uwe and Greg,
> 
> > You'd do a better deed if you picked up
> > http://thread.gmane.org/gmane.linux.kernel/1613364/focus=1635995
> 
> Since there is nothing wrong with the last version of the patch in
> the above thread, I feel strange about picking it up and just splitting
> it into two patches. However it would be good to have it applied.
> 
> I think the reason why the author didn't resend is that the object file
> and data structure layout information in the changelog depend on the
> changes to both .name and .dma_mask and by splitting the patch this
> information would not apply to any one of the resulting two patches.
> 
> Perhaps keeping this information in the changelog is a good reason for
> applying the patch as it is?

If you read the thread, I explained why I didn't want to take the patch
as-is.  Please feel free to break it up as asked for and I'll be glad to
consider it then.

thanks,

greg k-h
