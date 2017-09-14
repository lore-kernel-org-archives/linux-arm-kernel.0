From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Sep 2017 09:54:40 +0200
Subject: [PATCH] ARM: sun7i: a20: enable ac/battery power supplies for
 Lamobo R1 board
In-Reply-To: <20170913132130.56551-1-icenowy@aosc.io>
References: <20170913132130.56551-1-icenowy@aosc.io>
Message-ID: <20170914075440.6tpmom4l26wm6g6b@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 13, 2017 at 09:21:30PM +0800, Icenowy Zheng wrote:
> The Lamobo R1 board connected the ACIN of the AXP209 PMIC to a MicroUSB
> port, and the battery input is connected to a generic connector.
> 
> Enable these two power supplies in the device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied for 4.15, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170914/00bf11de/attachment.sig>
