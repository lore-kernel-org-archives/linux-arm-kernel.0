From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Mar 2016 11:09:36 +0100
Subject: [PATCH 1/3] ARM: dts: sun5i-a13-inet98v-rev2: Remove mmc2 node
In-Reply-To: <1457645884-10282-1-git-send-email-hdegoede@redhat.com>
References: <1457645884-10282-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160311100936.GW8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 10:38:02PM +0100, Hans de Goede wrote:
> The sun5i-a13-inet98v-rev2 does not have an emmc, it uses nand, the
> mmc2 node in the dts comes from a copy and paste error from the
> utoo-p66 dts, remove it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued for 4.7, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/0d5ac9be/attachment.sig>
