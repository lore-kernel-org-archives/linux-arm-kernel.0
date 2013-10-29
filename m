From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 29 Oct 2013 06:03:49 +0100
Subject: [PATCH 06/19] i2c: rcar: Enable the driver on all ARM platforms
In-Reply-To: <1383004027-25036-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131029050349.GC2643@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 12:46:54AM +0100, Laurent Pinchart wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> 
> Remove the explicit I2C dependency as the configuration option is
> already unavailable when I2C support is disabled.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/cc4564bf/attachment.sig>
