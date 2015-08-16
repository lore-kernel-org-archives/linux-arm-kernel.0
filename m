From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 16 Aug 2015 18:21:51 +0200
Subject: [PATCH] ARM: dts: sun4i: Enable i2c1 and i2c2 on the Chuwi
 V7-CW0825 tablet
In-Reply-To: <1439048334-14704-1-git-send-email-hdegoede@redhat.com>
References: <1439048334-14704-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150816162151.GE9000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 05:38:54PM +0200, Hans de Goede wrote:
> i2c1 has a freescale mma7660 accelerometer connected to it at addr 0x4c,
> i2c2 has a ft5x touchscreen connected to it at addr 0x38.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150816/ff8b8053/attachment-0001.sig>
