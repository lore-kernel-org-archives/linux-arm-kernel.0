From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Aug 2016 00:34:29 +0200
Subject: [PATCH 4/4] ARM: dts: sun8i: Rename reference-design-tablet
 touchscreen node
In-Reply-To: <20160826144226.29969-4-hdegoede@redhat.com>
References: <20160826144226.29969-1-hdegoede@redhat.com>
 <20160826144226.29969-4-hdegoede@redhat.com>
Message-ID: <20160826223429.GM3165@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 04:42:26PM +0200, Hans de Goede wrote:
> Rename the reference-design-tablet touchscreen node from gsl1680 to
> touchscreen, all? tablets seem to use the same power and interrupt
> gpio-s, but not all tablets use a gsl1680 controller making the
> gsl1680 name somewhat misleading.
> 
> Also move the reg and compatible property to the actual tablet dts
> as they may differ per tablet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/c17c16b4/attachment.sig>
