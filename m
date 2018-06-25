From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 25 Jun 2018 19:09:13 +0200
Subject: [PATCH 2/2] arm64: allwinner: a64: allow laptops to wake up from
 lid
In-Reply-To: <20180622160631.8578-2-icenowy@aosc.io>
References: <20180622160631.8578-1-icenowy@aosc.io>
 <20180622160631.8578-2-icenowy@aosc.io>
Message-ID: <20180625170913.p335obgr3rfa4skt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 23, 2018 at 12:06:31AM +0800, Icenowy Zheng wrote:
> Currently all ARM kernels will have s2idle enabled if CONFIG_SUSPEND is
> present. In this case if the lid is closed, systemd-logind will enter
> s2idle mode by default; however there's no possible wakeup source
> defined, so the system will enter a forever idle.
> 
> Add the lid itself as a wakeup source, thus the system can wakeup when
> the lid is opened.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied both, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180625/312ba8b4/attachment-0001.sig>
