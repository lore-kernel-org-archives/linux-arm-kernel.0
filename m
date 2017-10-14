From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Oct 2017 15:22:54 +0100
Subject: [PATCH v3 1/8] ARM: NOMMU: Move out MPU setup in separate module
In-Reply-To: <1506330344-31556-2-git-send-email-vladimir.murzin@arm.com>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
 <1506330344-31556-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20171014142254.GG20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 10:05:37AM +0100, Vladimir Murzin wrote:
> diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
> new file mode 100644
> index 0000000..ee3cf51
> --- /dev/null
> +++ b/arch/arm/mm/pmsa-v7.c
> @@ -0,0 +1,262 @@
> +/*
> + *  linux/arch/arm/mm/nommu.c
> + *
> + * ARM uCLinux supporting functions.

If this is for "a different MPU model" wouldn't it be better to say here?
uCLinux itself doesn't require a MPU (think pre-Cortex MMU-less systems.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
