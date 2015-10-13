From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 Oct 2015 10:37:41 +0200
Subject: [PATCH 03/37] ARM: mvebu: Armada 388 GP: Remove unneeded
 regulator property
In-Reply-To: <1444684386-17094-4-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1444684386-17094-4-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20151013103741.4ba34f90@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laurent,

On Tue, 13 Oct 2015 00:12:32 +0300, Laurent Pinchart wrote:
> The enable-active-high regulator property only makes sense when an
> enable GPIO is specified. Remove it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  arch/arm/boot/dts/armada-388-gp.dts | 2 --
>  1 file changed, 2 deletions(-)

Thanks, but this patch is no longer needed, since commit
b5999dcbdb96570c130772ac2055a4d34ec8b3d7 actually added the reference
to the gpio controlling the regulator.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
