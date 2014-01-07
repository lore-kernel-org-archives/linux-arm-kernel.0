From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 13:38:29 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140107130540.GA8090@e102568-lin.cambridge.arm.com>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
 <1387483575-11430-4-git-send-email-broonie@kernel.org>
 <20140107130540.GA8090@e102568-lin.cambridge.arm.com>
Message-ID: <20140107133829.GF31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 01:05:40PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Dec 19, 2013 at 08:06:14PM +0000, Mark Brown wrote:

> > +		/* check if the cpu is marked as "disabled", if so ignore */
> > +		if (!of_device_is_available(cn))
> > +			continue;

> It is time we defined what a "disabled" CPU means in ARM world, I need to
> have a proper look into this since this topic has been brought up before.

What is the confusion here - why would there be something architecture
specific going on?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/c7d57827/attachment.sig>
