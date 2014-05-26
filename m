From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 May 2014 15:49:15 +0800
Subject: linux-next: manual merge of the clockevents tree with the
 arm-soc tree
In-Reply-To: <20140526154331.7fc6b30c@canb.auug.org.au>
References: <20140526154331.7fc6b30c@canb.auug.org.au>
Message-ID: <20140526074913.GD2650@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Mon, May 26, 2014 at 03:43:31PM +1000, Stephen Rothwell wrote:
> Hi Daniel,
> 
> Today's linux-next merge of the clockevents tree got a conflict in
> arch/arm/boot/dts/vf610.dtsi between commit 0517fe6aa880 ("ARM: dts:
> vf610-twr: Add support for sdhc1") from the arm-soc tree and commit
> 07513e1330a9 ("ARM: dts: vf610: Add Freescale FlexTimer Module timer
> node") from the clockevents tree.

Next time, please leave the dts patches to go via arch tree, so that we
can save such conflicts.

Shawn
