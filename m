From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Feb 2011 15:05:39 +0100
Subject: [PATCH 2/4] arm: configs: update mmp2 defconfig for brownstone
	and SoC Selection
In-Reply-To: <04A50A49-CBBC-4E5D-B19E-391B4DF77DF3@marvell.com>
References: <04A50A49-CBBC-4E5D-B19E-391B4DF77DF3@marvell.com>
Message-ID: <201102141505.39981.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 February 2011, Philip Rakity wrote:
> took old mmp2_defconfig --
> did make menuconfig
> changed to CPU_MMP2
> added brownstone as supported board
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>

You should not use full .config files as defconfig any more these days.
Please use 'make defconfig' as a final step to create the minimum
list of config symbols. This applies to the other two as well.

	Arnd
