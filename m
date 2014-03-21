From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Mar 2014 13:39:17 +0000
Subject: [PATCH] ARM: topology: Make it clear that all CPUs need to be
 described
In-Reply-To: <20140321133202.GQ23372@e106331-lin.cambridge.arm.com>
References: <1395320374-29576-1-git-send-email-broonie@kernel.org>
 <20140321133202.GQ23372@e106331-lin.cambridge.arm.com>
Message-ID: <20140321133917.GQ11706@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 01:32:02PM +0000, Mark Rutland wrote:
> On Thu, Mar 20, 2014 at 12:59:34PM +0000, Mark Brown wrote:

> > -Any other configuration is consider invalid and therefore must be ignored.
> > +The nodes describing the CPU topology (cluster/core/thread) can only
> > +be defined within the cpu-map node and every core/thread in the system
> > +must be defined within the topology.  Any other configuration is
> > +consider invalid and therefore must be ignored.

> s/consider/considered/ (or drop the word entirely?).

Yup (that's a preexisting thing in the text that got reflowed).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/4da148ef/attachment-0001.sig>
