From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Sep 2013 15:38:48 +0100
Subject: [PATCH 3/4] spi: davinci: Allow SPI to be build without EDMA
 support
In-Reply-To: <52497E57.5080700@ti.com>
References: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
 <1380325356-2100-4-git-send-email-santosh.shilimkar@ti.com>
 <20130929123140.GU19304@sirena.org.uk> <52497E57.5080700@ti.com>
Message-ID: <20130930143848.GB19304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 09:36:23AM -0400, Santosh Shilimkar wrote:
> On Sunday 29 September 2013 08:31 AM, Mark Brown wrote:

> > If there's no hard dependency on EDMA then the driver probably ought to
> > be marked as COMPILE_TEST so that it can be build tested on other
> > systems.  Is that possible?

> EDMA is already getting tested for DAVINCI builds and there are patches
> coming AMXXXX SOC support. So probably marking it COMPILE_TEST isn't
> needed since it has been in use already for other SOCs.

It'd make life easier for general subsystem development if we were able
to get build coverage without having to build a specific config, even if
it's never actually going to be run.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130930/bcaa17e5/attachment.sig>
