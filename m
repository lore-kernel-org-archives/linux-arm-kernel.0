From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 10:31:59 +0100
Subject: [PATCH v3] clk: sunxi: Make the mod0 clk driver also a platform
 driver
In-Reply-To: <1419071809-22457-1-git-send-email-hdegoede@redhat.com>
References: <1419071809-22457-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150106093159.GE7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 20, 2014 at 11:36:49AM +0100, Hans de Goede wrote:
> With the prcm in sun6i (and some later SoCs) some mod0 clocks are instantiated
> through the mfd framework, and as such do not work with of_clk_declare, since
> they do not have registers assigned to them yet at of_clk_declare init time.
> 
> Silence the error on not finding registers in the of_clk_declare mod0 clk
> setup method, and also register mod0-clk support as a platform driver to work
> properly with mfd instantiated mod0 clocks.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/63b87190/attachment.sig>
