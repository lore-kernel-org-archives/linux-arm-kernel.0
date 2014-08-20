From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Wed, 20 Aug 2014 18:00:21 +0200
Subject: [PATCH 2/3] ARM: zynq: DT: Move size/address properties to dtsi
In-Reply-To: <1408550219-19825-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408550219-19825-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <53F4C615.9060908@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 20.08.2014 17:56, schrieb Soren Brinkmann:
> Move the GEM's size and address cells properties to the common
> dtsi file.
> 
> Cc: Andreas F?rber <afaerber@suse.de>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi      | 4 ++++
>  arch/arm/boot/dts/zynq-parallella.dts | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
