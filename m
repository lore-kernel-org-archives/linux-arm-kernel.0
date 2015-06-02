From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Jun 2015 10:24:26 +0200
Subject: [PATCH 1/2] clk: sunxi: Add support for the usb-clk on sun8i a23
 and a33 SoCs
In-Reply-To: <1433183008-13086-1-git-send-email-hdegoede@redhat.com>
References: <1433183008-13086-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150602082426.GQ23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 08:23:27PM +0200, Hans de Goede wrote:
> The usb-clk on sun8i a23 and a33 SoCs is similar to the ones found
> on sun6i-a31 SoCs but instead of a 3th phy the a23 / a33 have a hsic
> interface which gets enabled by almost the same bits as used on
> the a31 for the 3th phy, but not exactly the same bits so we need
> a new compatible for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied with Julian spelling fix.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/7d3de016/attachment.sig>
