From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Oct 2015 14:56:43 +0200
Subject: [PATCH v2] ARM: dts: sun6i: hummingbird: Add aliases for rtc
 devices
In-Reply-To: <1443703709-24835-1-git-send-email-wens@csie.org>
References: <1443703709-24835-1-git-send-email-wens@csie.org>
Message-ID: <20151001125643.GI7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 08:48:29PM +0800, Chen-Yu Tsai wrote:
> The hummingbird A31 has 2 rtc devices available: one in the SoC,
> and a pcf8563 external rtc on i2c2.
> 
> For some unknown reason, the onboard backup battery alone can not
> supply enough power to the internal rtc. When external power is
> removed, the internal rtc would reset. Hence we want to use the
> external one by default.
> 
> Add aliases for the rtc devices with the external one as rtc0.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Ordered the aliases alphabetically, and applied. Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/cff2e61f/attachment.sig>
