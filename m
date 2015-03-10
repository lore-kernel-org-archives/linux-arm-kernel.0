From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Mar 2015 22:34:13 +0100
Subject: [PATCH v2 1/2] ARM: dts: sunxi: Add address- and size-cells
 properties to the mmc ctrl nodes
In-Reply-To: <1426001230-15906-2-git-send-email-hdegoede@redhat.com>
References: <1426001230-15906-1-git-send-email-hdegoede@redhat.com>
 <1426001230-15906-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150310213413.GI5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 04:27:09PM +0100, Hans de Goede wrote:
> Sometimes we need to specify non-probably information for sdio devices in the
> devicetree, this is done through child nodes addressed by the reg property,
> whereby the reg property refers to the sdio function number, see;
> Documentation/devicetree/bindings/mmc/mmc.txt
> 
> This commit adds the necessary address- and size-cells properties to the mmc
> controller nodes in the dtsi files, so that dts files needing such a child
> node do not need to specify these themselves.
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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/e4309f67/attachment.sig>
