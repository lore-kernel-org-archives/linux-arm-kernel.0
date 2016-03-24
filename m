From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 24 Mar 2016 09:18:32 +0100
Subject: [PATCH 3/4] arm64: dts: marvell: Clean up armada-7040-db
In-Reply-To: <1458771861-12392-4-git-send-email-afaerber@suse.de>
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
 <1458771861-12392-4-git-send-email-afaerber@suse.de>
Message-ID: <20160324091832.0060c907@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 23 Mar 2016 23:24:20 +0100, Andreas F?rber wrote:
> Instead of duplicating the node hierarchy, reference the nodes by label,
> adding labels where necessary.
> 
> Drop some trailing or inconsistent white lines while at it.
> 
> Fixes: ec7e5a569bce ("arm64: dts: marvell: add Device Tree files for Armada 7K/8K")
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

We haven't used this solution on Marvell Armada 32-bits SoCs, so there
needs to be a discussion on whether we want to go in this direction for
the 64 bits SoCs.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
