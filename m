From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 22:03:33 +0200
Subject: [PATCH 0/2] ARM: sunxi: Convert DTSI to new CPU bindings
In-Reply-To: <20130628171532.GD30603@e102568-lin.cambridge.arm.com>
References: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130628171532.GD30603@e102568-lin.cambridge.arm.com>
Message-ID: <20130628200333.GA2756@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 06:15:32PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 28, 2013 at 05:44:02PM +0100, Maxime Ripard wrote:
> > Hi Arnd, Olof,
> > 
> > Sorry for steping in so late, but these two patches fixes a warning
> > introduced by the commit 1ba9bf0a (ARM: 7762/1: kernel: fix
> > arm_dt_init_cpu_maps() to skip non-cpu nodes) after 3.10-rc7.
> > 
> > These two patches solve the situation for sunxi. The first one by
> > Lorenzo is to be applied for 3.10 if it's still possible, and the
> > second one on top of arm-soc/for-next. Tell me if you prefer a more
> > formal pull request for these patches
> > 
> > Thanks!
> > Maxime
> > 
> > Lorenzo Pieralisi (1):
> >   ARM: dts: sunxi: cpus/cpu nodes dts updates
> 
> The patch above should already be queued in next/dt right ?

Indeed.

Then why the latest patch of your patchset got in 3.10, while the
patches actually fixing the DT it would have impacted were delayed to
3.11?

(And why was it merged so late in the development cycle?)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/ebf1b3eb/attachment.sig>
