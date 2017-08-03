From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 13:55:47 -0500
Subject: [PATCH] drm: hdlcd: allow HDLCD to be used without interrupt
In-Reply-To: <E1daJCF-0003pG-DI@rmk-PC.armlinux.org.uk>
References: <E1daJCF-0003pG-DI@rmk-PC.armlinux.org.uk>
Message-ID: <20170803185547.7k7twxihhwwvlajv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 11:05:39AM +0100, Russell King wrote:
> Some ARM platforms do not wire the HDLCD interrupt.  Allow hdlcd to
> initialise without an interrupt present.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  Documentation/devicetree/bindings/display/arm,hdlcd.txt |  6 +++---

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/arm/hdlcd_drv.c                         | 13 ++++++++-----
>  2 files changed, 11 insertions(+), 8 deletions(-)
