From: greg@kroah.com (Greg KH)
Date: Fri, 27 Sep 2013 08:25:21 -0700
Subject: [PATCH V5 5/9] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <877ge2l2qf.fsf@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1379761727-10656-1-git-send-email-manjunath.goudar@linaro.org>
 <1379761727-10656-6-git-send-email-manjunath.goudar@linaro.org>
 <877ge2l2qf.fsf@linaro.org>
Message-ID: <20130927152521.GA8450@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 08:10:32AM -0700, Kevin Hilman wrote:
> Manjunath,
> 
> Manjunath Goudar <manjunath.goudar@linaro.org> writes:
> 
> > Separate the  TI OHCI Atmel host controller driver from ohci-hcd
> > host code so that it can be built as a separate driver module.
> > This work is part of enabling multi-platform kernels on ARM.
> 
> This broke booting on atmel sama5 boards (and likely others with the
> same conversion)...

Crap.

And it looks like Manjunath is now no longer working at Linaro, so these
patches are "abandoned" :(

Unless someone at Linaro steps up in the next few days to fix these,
I'll have to go revert them all.  Again.

bleah.

greg k-h
