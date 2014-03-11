From: mporter@linaro.org (Matt Porter)
Date: Tue, 11 Mar 2014 11:50:02 -0400
Subject: [PATCH v2 2/5] mfd: add bcm590xx pmu driver
In-Reply-To: <20140219044605.GB2669@sirena.org.uk>
References: <1392765432-9111-1-git-send-email-mporter@linaro.org>
 <1392765432-9111-3-git-send-email-mporter@linaro.org>
 <20140219044605.GB2669@sirena.org.uk>
Message-ID: <20140311155002.GK25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:46:05PM +0900, Mark Brown wrote:
> On Tue, Feb 18, 2014 at 06:17:09PM -0500, Matt Porter wrote:
> 
> > +config MFD_BCM590XX
> > +	bool "Broadcom BCM590xx PMUs"
> > +	select MFD_CORE
> > +	select REGMAP_I2C
> > +	depends on I2C=y
> > +	help
> > +	  Support for the BCM590xx PMUs from Broadcom
> > +
> 
> Why does this need to be built in?

It doesn't. Just an oversight now fixed in v3.

-Matt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/406757c6/attachment.sig>
