From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 16:52:58 +0100
Subject: [PATCH 05/17] ARM: dts: sunxi: Enable thermal sensor support for
 RTP on sun[457]i
In-Reply-To: <1420511727-8242-6-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-6-git-send-email-wens@csie.org>
Message-ID: <20150106155258.GQ7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 10:35:15AM +0800, Chen-Yu Tsai wrote:
> Now that the resistive touchpanel driver supports thermal sensors,
> add the "#thermal-sensor-cells" property as required by the thermal
> framework.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/6ba7e47b/attachment.sig>
