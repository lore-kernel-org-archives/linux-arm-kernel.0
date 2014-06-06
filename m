From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Jun 2014 14:08:50 +0100
Subject: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
In-Reply-To: <20140606125003.GA13332@verge.net.au>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
 <20140606111411.GD25896@verge.net.au>
 <CANqRtoTy_LwSiZgRFEw5Ly4ojfinoCichxrX7cO6m2XB9JGoww@mail.gmail.com>
 <20140606125003.GA13332@verge.net.au>
Message-ID: <20140606130850.GO2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 09:50:06PM +0900, Simon Horman wrote:
> On Fri, Jun 06, 2014 at 09:14:01PM +0900, Magnus Damm wrote:

> > I'm not sure about the expected merge order for this kind of change vs
> > queued up stuff in the renesas git tree, but I believe the following
> > patch selects ARCH_HAS_OPP:

> > [PATCH v3] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable

> I propose that we fix that up by adding an incremental patch to
> mach-shmobile via my renesas tree once the dependency (assuming there is
> one) is in Linus's tree.

Yes, the conversion to make ARCH_HAS_OPP unused is in Raphael's tree for
the merge window.  I'd expect this patch to end up going after the merge
window (or at the end I guess).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/e1c776b1/attachment.sig>
