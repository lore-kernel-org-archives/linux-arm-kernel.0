From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Wed, 13 Apr 2011 08:43:48 +0100
Subject: [alsa-devel] [PATCH] ARM: s3c2440: gta02; Register dfbmcs320
	device
In-Reply-To: <1302641464-27494-1-git-send-email-lars@metafoo.de>
References: <1302641464-27494-1-git-send-email-lars@metafoo.de>
Message-ID: <1302680628.3600.15.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-04-12 at 22:51 +0200, Lars-Peter Clausen wrote:
> Register the dfbmcs320 device which provides the PCM DAI for the bluetooth
> module.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s3c2440/mach-gta02.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
