From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Feb 2018 14:35:29 +0100
Subject: [PATCH v3 3/5] arm64: dts: renesas: r8a7795-es1: Fix register
 mappings on VSPs
In-Reply-To: <2009459.7Q8ChOu4tJ@avalon>
References: <1518602108-1724-1-git-send-email-kbingham@kernel.org>
 <1518602108-1724-4-git-send-email-kbingham@kernel.org>
 <2009459.7Q8ChOu4tJ@avalon>
Message-ID: <20180216133528.nlf6srnitp66xeey@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 12:08:56PM +0200, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Wednesday, 14 February 2018 11:55:06 EET Kieran Bingham wrote:
> > From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > 
> > The VSPD includes a CLUT on RPF2. Ensure that the register space is
> > mapped correctly to support this.
> > 
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, applied.
