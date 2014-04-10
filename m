From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Apr 2014 14:39:41 +0200
Subject: [PATCH v2 2/5] pinctrl: sunxi: support multiple pin controller
In-Reply-To: <1397132747-13917-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397132747-13917-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140410123941.GQ28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 02:25:44PM +0200, Boris BREZILLON wrote:
> Add support for multiple pin controller instances.
> 
> First remove the static definition of the sunxi gpio chip struct and fill
> the dynamically struct instead.
> Then define a new pin_base field in the sunxi_pinctrl_desc which will be
> used to specify the gpiochip base pin.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/d056c55e/attachment-0001.sig>
