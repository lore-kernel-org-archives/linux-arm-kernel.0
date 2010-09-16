From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 16 Sep 2010 11:56:45 +0200
Subject: [PATCH] ARM: New option for generating uncompressed uImage.
In-Reply-To: <20100916090439.GC20197@n2100.arm.linux.org.uk>
References: <1284621783-8196-1-git-send-email-jonas.aberg@stericsson.com>
	<20100916090439.GC20197@n2100.arm.linux.org.uk>
Message-ID: <20100916095645.GC17016@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:04 Thu 16 Sep     , Russell King - ARM Linux wrote:
> On Thu, Sep 16, 2010 at 09:23:03AM +0200, Jonas Aaberg wrote:
> > Some systems do boot faster with an uncompressed kernel.
> 
> Do this externally.  uImage in the kernel build is a pain in the
> backside because different people want different things from it.
we drop this from barebox you can now boot the zImage or the raw image
directly

we keep the uImage for the ones that still want to use it

Best Regards,
J.
