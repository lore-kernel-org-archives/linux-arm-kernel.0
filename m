From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jan 2014 23:40:20 +0100
Subject: [PATCH v2 8/8] arm: sun7i: cubietruck: Enable the i2c controllers
In-Reply-To: <1388987892-23733-9-git-send-email-wens@csie.org>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
 <1388987892-23733-9-git-send-email-wens@csie.org>
Message-ID: <20140107224020.GI3103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 06, 2014 at 01:58:12PM +0800, Chen-Yu Tsai wrote:
> The Cubietruck makes use of the first three i2c controllers found on the
> Allwinner A20; i2c-0 is used internally for the PMIC, i2c-1 is exposed on
> the board headers, and i2c-2 is used for DDC on the VGA connector. This
> patch enables them in the device tree.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

It's not really related to the rest of the patches, so I would have
prefered it being send as a separate patch.

Anyway, it's merged now :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/58bc78e1/attachment.sig>
