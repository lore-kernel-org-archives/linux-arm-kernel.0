From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jun 2016 22:44:51 +0200
Subject: [PATCH] ARM: dts: sun5i-a10s-wobo-i5: Enable ldo4 too
In-Reply-To: <1464977440-23441-1-git-send-email-hdegoede@redhat.com>
References: <1464977440-23441-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160607204451.GC14179@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 08:10:40PM +0200, Hans de Goede wrote:
> It seems that the wifi chip is powered by both ldo3 and ldo4 tied
> together and that using only one results in the wifi-chip dropping of
> the USB bus sometimes.
> 
> Ideally we would have a proper way of modelling this (this is being
> worked on), but currently we do not. This is not an issue since we need
> to keep these regulators always-on anyways, due to these boards
> crashing when ldo3/4 get turned back on after having been turned off.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/2a4c5755/attachment.sig>
