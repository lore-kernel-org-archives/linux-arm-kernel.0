From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Fri, 19 Sep 2014 12:39:59 +0200
Subject: [PATCH resend v5 0/2] ARM: sunxi: RTC support for A31/A23
In-Reply-To: <1409025296-6342-1-git-send-email-wens@csie.org>
References: <1409025296-6342-1-git-send-email-wens@csie.org>
Message-ID: <20140919103959.GO2166@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:54:54AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> Resending the sun6i RTC series, rebased onto 3.17-rc1.
> The DT/defconfig patches have been queued for 3.18, and therefore
> dropped from this series. Hope we can get the driver parts in as
> well.
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

Ok, I ended up merging the two patches.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140919/f4de4f7d/attachment-0001.sig>
