From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Tue, 20 Dec 2011 12:36:37 +0100
Subject: [PATCH 1/8] s3c-hsudc: move platform_data struct to global header
In-Reply-To: <20111220112458.GG31842@legolas.emea.dhcp.ti.com>
References: <201112191938.22254.heiko@sntech.de>
 <201112191939.16542.heiko@sntech.de>
 <20111220112458.GG31842@legolas.emea.dhcp.ti.com>
Message-ID: <201112201236.37581.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 20. Dezember 2011, 12:25:00 schrieb Felipe Balbi:
> Hi,
> 
> On Mon, Dec 19, 2011 at 07:39:15PM +0100, Heiko St?bner wrote:
> > Gadget drivers should be compilable on all architectures.
> > This patch removes one dependency on architecture-specific code.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  arch/arm/mach-s3c2416/mach-smdk2416.c    |    1 +
> >  arch/arm/plat-samsung/devs.c             |    1 +
> >  arch/arm/plat-samsung/include/plat/udc.h |   15 +------------
> 
> I would like to have ack from Ben and/or Kukjin before applying this
> one. Ben are you ok with this patch ?
I think Kukjin does more acking if this stuff currently, so hopefully he will 
see this mail.

Heiko
