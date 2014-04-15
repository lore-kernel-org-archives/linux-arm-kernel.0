From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Apr 2014 16:44:16 +0200
Subject: [PATCH 6/7] net: rfkill: gpio: add clock-frequency device tree
 property
In-Reply-To: <1397544101-18135-7-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-7-git-send-email-wens@csie.org>
Message-ID: <20140415144416.GH3207@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 02:41:40PM +0800, Chen-Yu Tsai wrote:
> Some devices, such as Broadcom Bluetooth devices, require a specific
> clock rate for the clock tied to the rfkill device. Add a clock-frequency
> property so we can specify this from the device tree.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I think such a property belongs to the device that requires it, and
not to the rfkill that controls it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/a7fd7000/attachment.sig>
