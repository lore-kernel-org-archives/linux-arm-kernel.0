From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 27 Jul 2018 14:59:12 +0200
Subject: [PATCH v3.1 00/10] arm64: allwinner: Add A64 DE2 HDMI support
In-Reply-To: <20180726171257.6688-1-icenowy@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io>
Message-ID: <20180727125912.e5js7krmthto6gmz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 01:12:47AM +0800, Icenowy Zheng wrote:
> Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T/H3/H5.
> 
> A64 behaviour similar to Allwinner A83T where
> Mixer0 => TCON0 => LVDS/RGB/MIPI-DSI
> Mixer1 => TCON1 => HDMI
> as per Display System Block Diagram from the A64 user manual.
> 
> This is third patch-set followed with previous RFC[1], first and second
> series[2][3] and merely concentrated on HDMI pipeline through TCON1 and
> rest will add eventually.
> 
> I just rebased and slightly re-integrated the patchset according to the
> requirments of the maintainer, and added the mixer0->tcon0 pipeline.
> The further maintainship of the patchset still needs to be discussed
> between I and Jagan.

Beside the comment on the pine64, it looks good to me. Can you
resubmit those patches after rc1 is out?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180727/c5bd4d24/attachment.sig>
