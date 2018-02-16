From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Feb 2018 14:37:00 +0100
Subject: [PATCH v3 5/5] arm64: dts: renesas: r8a7796: Fix register
 mappings on VSPs
In-Reply-To: <1518602108-1724-6-git-send-email-kbingham@kernel.org>
References: <1518602108-1724-1-git-send-email-kbingham@kernel.org>
 <1518602108-1724-6-git-send-email-kbingham@kernel.org>
Message-ID: <20180216133659.s4xf3ovi63fkwuyg@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 09:55:08AM +0000, Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> The VSPD includes a CLUT on RPF2. Ensure that the register space is
> mapped correctly to support this.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, applied.
