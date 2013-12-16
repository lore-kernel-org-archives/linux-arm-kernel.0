From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Dec 2013 11:52:00 +0100
Subject: [PATCH v3] ARM: dts: sun5i: Add new sun5i-a13-olinuxino-micro
 board
In-Reply-To: <1387135416-16180-1-git-send-email-hdegoede@redhat.com>
References: <1387135416-16180-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20131216105200.GI3037@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 15, 2013 at 08:23:36PM +0100, Hans de Goede wrote:
> The A13-OLinuXino-MICRO is a small dev-board with the Allwinner A13 SoC:
> https://www.olimex.com/Products/OLinuXino/A13/A13-OLinuXino-MICRO/
> 
> Features:
> A13 Cortex A8 processor at 1GHz, 3D Mali400 GPU
> 256 MB RAM (128Mbit x 16)
> 5VDC input power supply with own ICs, noise immune design
> 1 USB host
> 1 USB OTG which can power the board
> SD-card connector for booting the Linux image
> VGA video output
> LCD signals available on connector so you still can use LCD if you disable VGA/HDMI
> Audio output
> Microphone input pads (no connector)
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied in sunxi/dt-for-3.14.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/590db27d/attachment.sig>
