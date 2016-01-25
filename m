From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 Jan 2016 12:24:29 +0000
Subject: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
In-Reply-To: <1453710902.2521.203.camel@linux.intel.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
 <20160124223629.GI6588@sirena.org.uk>
 <1453710902.2521.203.camel@linux.intel.com>
Message-ID: <20160125122429.GN6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 10:35:02AM +0200, Andy Shevchenko wrote:
> On Sun, 2016-01-24 at 22:36 +0000, Mark Brown wrote:

> > This is patch 3 of a series but I don't have anything else in the
> > series.??What is going on with the rest of the series - what are the
> > dependencies and so on?

> Mark, sorry about that, but in this particular case you may consider
> this patch is a standalone one. You are in the Cc list due to SPI
> driver small change. This change isn't modifying functionality of the
> driver.

And there's no dependency relationship with the rest of the series?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/8fc890a0/attachment.sig>
