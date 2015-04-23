From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Apr 2015 17:56:52 +0200
Subject: [PATCH 1/4] ARM: perf: don't warn about missing
 interrupt-affinity property for PPIs
In-Reply-To: <1429797033-3787-1-git-send-email-will.deacon@arm.com>
References: <1429797033-3787-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150423155652.GD28007@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 02:50:30PM +0100, Will Deacon wrote:
> PPIs are affine by nature, so the interrupt-affinity property is not
> used and therefore we shouldn't print a warning in its absence.
> 
> Reported-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

For this one and the arm64 one,

Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150423/2a8fb712/attachment.sig>
