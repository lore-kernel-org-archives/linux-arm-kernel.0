From: horms@verge.net.au (Simon Horman)
Date: Thu, 27 Oct 2016 09:15:24 +0200
Subject: [PATCH] arm64: defconfig: Enable DRM DU and V4L2 FCP + VSP modules
In-Reply-To: <20161027070801.GB7706@verge.net.au>
References: <20161026052422.17283.57864.sendpatchset@little-apple>
 <20161027070801.GB7706@verge.net.au>
Message-ID: <20161027071523.GD7706@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 09:08:01AM +0200, Simon Horman wrote:
> On Wed, Oct 26, 2016 at 02:24:22PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> > 
> > Extend the ARM64 defconfig to enable the DU DRM device as module
> > together with required dependencies of V4L2 FCP and VSP modules.
> > 
> > This enables VGA output on the r8a7795 Salvator-X board.
> > 
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Thanks, I have queued this up.

Given discussion elsewhere on enabling DU I am holding off on this for a
little; it is not queued up for now.
