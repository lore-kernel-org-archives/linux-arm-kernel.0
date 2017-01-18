From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jan 2017 14:23:03 +0100
Subject: [PATCH 2/2] ARM: DTS: Fix register map for virt-capable GIC
In-Reply-To: <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
References: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
 <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20170118132303.zswjourymirskkoc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 10:53:31AM +0000, Marc Zyngier wrote:
> Since everybody copied my own mistake from the DT binding example,
> let's address all the offenders in one swift go.
> 
> Most of them got the CPU interface size wrong (4kB, while it should
> be 8kB), except for both keystone platforms which got the control
> interface wrong (4kB instead of 8kB).
> 
> In the couple of cases were I knew for sure what implementation
> was used, I've added the "arm,gic-400" compatible string. I'm 99%
> sure that this is what everyong is using, but short of having the
> TRM for all the other SoCs, I've let them alone.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/f8a15ae6/attachment.sig>
