From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Jan 2014 00:02:42 +0100
Subject: [PATCH v3 5/5] ARM: dts: sun7i: Add pin muxing options for clock
 outputs
In-Reply-To: <1388543450-16741-6-git-send-email-wens@csie.org>
References: <1388543450-16741-1-git-send-email-wens@csie.org>
 <1388543450-16741-6-git-send-email-wens@csie.org>
Message-ID: <20140101230242.GD3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Wed, Jan 01, 2014 at 10:30:50AM +0800, Chen-Yu Tsai wrote:
> This patch adds the clock output pin options on the A20.
> The 2 pins can output a configurable clock to be used by
> external modules. This is used on the CubieTruck, to supply
> a 32768 Hz low power clock to the onboard Wifi+BT module.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied to sunxi/dt-for-3.14.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140102/b035ea56/attachment.sig>
