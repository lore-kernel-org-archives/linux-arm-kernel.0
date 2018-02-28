From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Feb 2018 16:54:59 +0000
Subject: [PATCH] arm64: dts: juno: fix size of GICv2m MSI frames
In-Reply-To: <1519832935-7338-1-git-send-email-sudeep.holla@arm.com>
References: <20180207143255.17003-3-marc.zyngier@arm.com>
 <1519832935-7338-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <86woyx2gws.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Feb 2018 15:48:55 +0000,
sudeep holla wrote:
> 
> Currently the size of GICv2m MSI frames are listed as 4kB while the
> Juno TRM specifies 64kB for each of these MSI frames.
> 
> Though the devices connected themself might just use the first 4kB,
> to be consistent with the genaral practice of 64kB boundary alignment
> to all the devices, lets keep the size as 64kB. This might also help
> in avoiding any surprise when passing the device to a VM.
> 
> This patch increase the size of each GICv2m MSI frames from 4kB to 64kB
> as per the specification.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
