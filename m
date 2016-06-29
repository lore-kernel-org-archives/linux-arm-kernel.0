From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 22:36:15 +0200
Subject: [PATCH 4/4] ARM: dts: sun5i: Add mmc1 / sdio-wifi node to mk802
In-Reply-To: <1467226022-10525-4-git-send-email-hdegoede@redhat.com>
References: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
 <1467226022-10525-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20160629203615.GH6095@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 08:47:02PM +0200, Hans de Goede wrote:
> The a10s mk802 uses a rtl8189es sdio wifi chip, add a node enabling
> the mmc1 controller, this enables using the wifi chip (together with
> an out of tree sdio driver for it).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160629/97fb5f15/attachment.sig>
