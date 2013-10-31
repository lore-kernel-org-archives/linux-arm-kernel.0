From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Oct 2013 10:49:45 -0700
Subject: [PATCH v3] iommu: shmobile: Enable the driver on all ARM platforms
In-Reply-To: <20131031060305.GU1603@verge.net.au>
References: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131030112625.GZ16735@n2100.arm.linux.org.uk>
 <1652955.Gs3XDiEUHO@avalon> <20131030162854.GB2493@sirena.org.uk>
 <20131031060305.GU1603@verge.net.au>
Message-ID: <20131031174945.GI2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 03:03:05PM +0900, Simon Horman wrote:
> On Wed, Oct 30, 2013 at 09:28:54AM -0700, Mark Brown wrote:
> > On Wed, Oct 30, 2013 at 12:40:12PM +0100, Laurent Pinchart wrote:

> > > > For similar reasons as x86, can we please think about using:
> > 
> > > > 	depends on ARM
> > > > 	depends on ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI || COMPILE_TEST

> > I'd read the above as saying the code needs ARM to build at all and that
> > the hardware will only ever appear on SHMOBILE.

> I am curious to know the value of "depends ARM".
> Is it to aid the reading that you spelt out?

That's a function of the compile time dependencies, if ARM is required
to build then it needs to be an unconditional dependency.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131031/b091cd0a/attachment-0001.sig>
