From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 11:08:30 +0200
Subject: [PATCH v2 01/20] serial: 8250_dw: Add optional reset control
 support
In-Reply-To: <1403016777-15121-2-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-2-git-send-email-wens@csie.org>
Message-ID: <20140618090830.GH19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:38PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A31 and A23 SoCs have a reset controller
> maintaining the UART in reset by default.
> 
> This patch adds optional reset support to the driver.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/c5efbb5c/attachment.sig>
