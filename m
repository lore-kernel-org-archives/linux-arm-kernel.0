From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Aug 2016 00:32:10 +0200
Subject: [PATCH 1/4] ARM: dts: sun4i: Disable ohci1 on ba10-tv-box
In-Reply-To: <20160826144226.29969-1-hdegoede@redhat.com>
References: <20160826144226.29969-1-hdegoede@redhat.com>
Message-ID: <20160826223210.GJ3165@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 04:42:23PM +0200, Hans de Goede wrote:
> The ehci1/ohci1 pair on the ba10-tv-box is connected to an USB-2 wifi
> module soldered on the PCB, so there enabling ohci1 is not necessary.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/3ea4403c/attachment.sig>
