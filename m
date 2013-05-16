From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 May 2013 12:59:07 +0100
Subject: [PATCH] ARM: dove: add a kms/drm driver
In-Reply-To: <20130516132822.09b883cf@armhf>
References: <20130516132822.09b883cf@armhf>
Message-ID: <20130516115907.GQ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 01:28:22PM +0200, Jean-Francois Moine wrote:
> This patch adds a KMS/DRM video driver for the LCD and display
> controllers of the Marvell's Dove SoC.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

I want to review this as I have a competing driver which offers full
support for the Dove cubox including a fully accelerated X server,
and overlay support, page flipping and so forth.
