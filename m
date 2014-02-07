From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Feb 2014 20:30:00 +0100
Subject: [PATCH v4 1/5] clk: sunxi: Add support for USB clock-register
 reset bits
In-Reply-To: <1391786513-20780-2-git-send-email-hdegoede@redhat.com>
References: <1391786513-20780-1-git-send-email-hdegoede@redhat.com>
 <1391786513-20780-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140207193000.GP3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 04:21:49PM +0100, Hans de Goede wrote:
> The usb-clk register is special in that it not only contains clk gate bits,
> but also has a few reset bits. This commit adds support for this by allowing
> gates type sunxi clks to also register a reset controller.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140207/eb93acaa/attachment-0001.sig>
