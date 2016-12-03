From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 3 Dec 2016 13:08:05 +0000
Subject: [PATCH] arm64: dts: zte: clean up gic-v3 redistributor properties
In-Reply-To: <1480768600-20827-1-git-send-email-shawnguo@kernel.org>
References: <1480768600-20827-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20161203130805.61b1f85c@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 3 Dec 2016 20:36:40 +0800
Shawn Guo <shawnguo@kernel.org> wrote:

> The gic-v3 property redistributor-stride is only meant as a workaround
> for broken platforms that have a redistributor stride deviating what the
> architecture defines, i.e. 128KiB for GICv3, 256KiB for GICv4.  This is
> not the case for ZX296718, and redistributor-stride is not really
> necessary.  Let's drop it.
> 
> Also, #redistributor-regions is only required when there is more than
> one such region is present.  Let's remove it as well.
> 
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.
