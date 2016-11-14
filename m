From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Nov 2016 20:53:34 +0100
Subject: [PATCH] ARM: dts: sun8i: replace enable-sdio-wakeup with
 wakeup-source for BananaPi M1+
In-Reply-To: <1479138250-17780-4-git-send-email-sudeep.holla@arm.com>
References: <1479138250-17780-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <20161114195334.62rvyagvgeovhobq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 03:44:10PM +0000, Sudeep Holla wrote:
> Though the mmc core driver will continue to support the legacy
> "enable-sdio-wakeup" property to enable SDIO as the wakeup source,
> "wakeup-source" is the new standard binding.
> 
> This patch replaces the legacy "enable-sdio-wakeup" with the unified
> "wakeup-source" property in order to avoid any further copy-paste
> duplication.
> 
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/a2450401/attachment.sig>
