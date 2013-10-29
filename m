From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Oct 2013 09:40:57 -0700
Subject: [PATCH 16/19] spi: sh_msiof: Enable the driver on all ARM
 platforms
In-Reply-To: <1383004027-25036-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131029164057.GB6776@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 12:47:04AM +0100, Laurent Pinchart wrote:

> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI and increase build testing coverage.

Why is this driver specific to ARM?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/6edc84e7/attachment.sig>
