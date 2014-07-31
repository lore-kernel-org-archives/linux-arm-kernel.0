From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Jul 2014 11:55:55 +0200
Subject: [PATCH v5 0/6] ARM: sunxi: RTC support for A31/A23
In-Reply-To: <1406724969-2482-1-git-send-email-wens@csie.org>
References: <1406724969-2482-1-git-send-email-wens@csie.org>
Message-ID: <20140731095555.GZ3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 30, 2014 at 08:56:03PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v5 of the sun6i RTC series. This series adds support for
> the RTC in A31 and A23 SoCs. The series applies to sunxi-next.
> 
> The A31 has a new RTC block that is separate from the timer block.
> It has separate interrupts for each of the alarms, and a different
> format for the counter alarm. The driver has been tested on the
> A31 Hummingbird, and the A23 tablet I'm using to work on sun8i
> support.
> 
> Patch 1 adds the driver for the RTC.
> 
> Patch 2 is a minor cleanup. This makes rtc-sunxi depend on sun4i or
> sun7i, the 2 platforms the driver is actually used on.
> 
> Patch 3 adds the RTC device node to the sun6i DTSI.
> 
> Patch 4 adds the RTC device node to the sun8i DTSI.
> 
> Patch 5 adds enables rtc-sun6i in the sunxi defconfig.
> 
> Patch 6 adds enables rtc-sun6i in the multi_v7 defconfig.
> This patch applies to arm-soc/next/defconfig (e9a86d96)

I queued patches 3 to 6 for 3.18.

I'll rebase a publish the branches as soon as 3.17-rc1 is out, so
don't worry if you don't see these patches appear right away.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/929c1dbe/attachment-0001.sig>
