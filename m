From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Jun 2016 21:48:18 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable USB FFS gadget
In-Reply-To: <1466496357-17006-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1466496357-17006-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <20160621134818.GB26954@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 10:05:57AM +0200, Gary Bisson wrote:
> The USB Function FS gadget can be very useful for debugging.
> 
> For instance, the adbd daemon can leverage this gadget to
> offer an ADB connection to the platform over USB.
> 
> Note that adbd is available on many OS/build systems:
> - Ubuntu: see android-tools-adbd package [1]
> - Yocto: see meta-smartphone android-tools recipe [2]
> - Buildroot: see android-tools package [3]
> 
> [1] http://packages.ubuntu.com/trusty/android-tools-adbd
> [2] https://github.com/shr-distribution/meta-smartphone/tree/shr/meta-android/recipes-android/android-tools
> [3] https://git.buildroot.net/buildroot/tree/package/android-tools
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>

Applied, thanks.
