From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 16:27:04 +0100
Subject: [PATCH v3 RESEND] drm/i2c: tda998x: Fix lack of required reg
 in DT documentation
In-Reply-To: <20140619104732.4ae7f6d3@armhf>
References: <20140619104732.4ae7f6d3@armhf>
Message-ID: <20140702152704.GL32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 10:47:32AM +0200, Jean-Francois Moine wrote:
> The I2C address (reg) is required for the TDA998x driver to be loaded
> and initialized.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> - v3
> 	- change subject to drm/i2c
> - v2
> 	- don't force the I2C address to be 0x70
> This patch applies to linux-next.

I had hoped that DT people would pick this up, as it's touching their
documentation.  However, it seems not, so I've added it to my fixes
queue, which I'll send RSN to David.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
