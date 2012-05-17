From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 17 May 2012 08:06:01 -0700
Subject: [PATCH] ARM: at91: Add ADC driver to at91sam9260/at91sam9g20
 dtsi files
In-Reply-To: <201205161850.54765.arnd@arndb.de>
References: <4FB3B1F3.6080102@atmel.com>
 <1337182626-13033-1-git-send-email-nicolas.ferre@atmel.com>
 <201205161850.54765.arnd@arndb.de>
Message-ID: <20120517150601.GA28104@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 06:50:54PM +0000, Arnd Bergmann wrote:
> On Wednesday 16 May 2012, Nicolas Ferre wrote:
> > Now that the bulk of at91sam9g20-related nodes are located in at91sam9260.dtsi,
> > we have to re-create the path to this ADC node for SoC specific parts.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Should we apply this patch in arm-soc so that Greg can drop the hunk that
> no longer applies?

It's not a "no longer applies", it's a "this does not merge".  The patch
is in my tree, unless you want me to revert it, it's going to stay there
until it goes to Linus.

thanks,

greg k-h
