From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Aug 2016 09:08:13 +0200
Subject: [PATCH 0/2] ARM: dts: alt: add SDHI0 and 1, and MMCIF support
In-Reply-To: <1470745144-5394-1-git-send-email-horms+renesas@verge.net.au>
References: <1470745144-5394-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160817070813.GF8673@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 02:19:02PM +0200, Simon Horman wrote:
> Hi,
> 
> this short series enables SDHI 0 and 1, and MMCIF on the r8a7794/Alt board.
> The SDHI IP blocks are exposed as SD card slots while the MMCIF block
> is wired up to on-board eMMC.
> 
> N.B.: I do not currently have physical access to an Alt board but I do
>       have remote access which I used to test these patches.
> 
> Simon Horman (2):
>   ARM: dts: alt: add SDHI0 and 1 support
>   ARM: dts: alt: add MMCIF support

I have queued these up.
