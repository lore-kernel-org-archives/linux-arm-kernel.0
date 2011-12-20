From: balbi@ti.com (Felipe Balbi)
Date: Tue, 20 Dec 2011 13:25:00 +0200
Subject: [PATCH 1/8] s3c-hsudc: move platform_data struct to global header
In-Reply-To: <201112191939.16542.heiko@sntech.de>
References: <201112191938.22254.heiko@sntech.de>
 <201112191939.16542.heiko@sntech.de>
Message-ID: <20111220112458.GG31842@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 19, 2011 at 07:39:15PM +0100, Heiko St?bner wrote:
> Gadget drivers should be compilable on all architectures.
> This patch removes one dependency on architecture-specific code.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-s3c2416/mach-smdk2416.c    |    1 +
>  arch/arm/plat-samsung/devs.c             |    1 +
>  arch/arm/plat-samsung/include/plat/udc.h |   15 +------------

I would like to have ack from Ben and/or Kukjin before applying this
one. Ben are you ok with this patch ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111220/d9343b33/attachment.sig>
