From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Oct 2015 12:11:26 +0200
Subject: [PATCH] ARM: dts: sun6i: hummingbird: Add aliases for rtc devices
In-Reply-To: <1443600937-11071-1-git-send-email-wens@csie.org>
References: <1443600937-11071-1-git-send-email-wens@csie.org>
Message-ID: <20151001101126.GD7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 30, 2015 at 04:15:37PM +0800, Chen-Yu Tsai wrote:
> The hummingbird A31 has 2 rtc devices available: one in the SoC, and
> a pcf8563 external rtc on i2c2.
> 
> For some unknown reason, the onboard backup battery to power the
> internal rtc when power is removed, and its time would reset. Hence
> we want to use the external one by default.

The patch looks fine, but I'm not sure to understand the first
sentence of that paragraph :/

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/e461eb1a/attachment.sig>
