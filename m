From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 Jun 2017 11:06:03 +0200
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <20170606110234.239d2c4a@free-electrons.com>
References: <20170605200107.7692-1-marc.zyngier@arm.com>
 <20170606110234.239d2c4a@free-electrons.com>
Message-ID: <20170606110603.2dafb7ed@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 6 Jun 2017 11:02:34 +0200, Thomas Petazzoni wrote:

> This patch is somewhat redundant with
> https://patchwork.kernel.org/patch/9728207/, which despite the flaming
> discussion that followed, does the same thing (and more).

That being said, the patch from Marcin was also enabling SDHCI, which
has already been enabled in the mean time by a patch from Russell.

So perhaps we should indeed keep Marc's patch, enabling just the 1GB
Ethernet interface.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
