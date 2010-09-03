From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Fri, 3 Sep 2010 09:41:04 +0300
Subject: [PATCH 0/6] add spi support for i.MX51 in the existing spi_imx
	driver
In-Reply-To: <4C8068FD.1090705@gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<20100902082759.GE14214@pengutronix.de>
	<4C7F777E.1090104@gmail.com>
	<20100902143908.GK14214@pengutronix.de>
	<4C8068FD.1090705@gmail.com>
Message-ID: <20100903064104.GA2965@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Sep 03, Jason Wang wrote:
> Uwe Kleine-K?nig wrote:
> >Hello Jason,
> >
> >>>Actually I would prefer our patches, but of course I'm biased :-)
> >>>
> >>>I don't know how we should handle this.  And Sascha is on vacation this
> >>>and next week.  I will investigate if our patches are already free to be
> >>>posted.
> >OK, I can post our patches.  I think the driver part is quite similar,
> >the platform part is not.  But look for yourself, I'll post them in reply to
> >this mail.  Hopefully we can join forces to get the best out of the two
> >approaches.
> OK, glad to see the refine of platform header files.
> >BTW, we're working on nand (David merged an early patch series by
> >Sascha, we have some fixes pending), mc19892 and ipuv3, too.  Just to
> >notice the possibility for more cooperation early. :-)
> >
> Good news, after add sdma, mc13892 and ipuv3, the i.MX51 will
> be like a real useful platform. :-)

Jason, Uwe,

Can we put up a wiki page of what drivers are being worked on by who so we
don't work on the same drivers?

We are planning to look at the power management aspects of the i.MX51 at Linaro.

/Amit

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
