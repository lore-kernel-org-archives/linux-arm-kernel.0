From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 May 2014 19:08:43 +0200
Subject: [PATCH v12 0/6] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>
References: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140511170843.GT7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sun, May 11, 2014 at 09:46:51AM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v12 of the sunxi-mmc patch-set David Lanzend?rfer and I have been
> working on, the mmc driver itself is unchanged from v11. New this version are
> some dts patch changes, see below.
> 
> The first patch in this series is the patch adding the actual mmc driver and
> should go in through the mmc tree.
> 
> All the other patches are devicetree patches adding / using the new fixed
> reg_vcc3v3 supply to all sunxi board files, and should go upstream through
> Maxime's sunxi-dts tree.

I just merged the last 5 patches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140511/35d4d738/attachment.sig>
