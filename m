From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Apr 2014 14:43:42 +0200
Subject: [PATCH v2 3/5] pinctrl: sunxi: define A31 R_PIO pin functions
In-Reply-To: <1397132747-13917-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1397132747-13917-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397132747-13917-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140410124342.GR28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 02:25:45PM +0200, Boris BREZILLON wrote:
> The A31 SoC provides both PL and PM pio bank through the R_PIO block.
> 
> These pins all support gpio function and can bbe assigned to system
> peripherals (like TWI, P2WI, JTAG, ...)
> 
> Add new compatible string to the DT bindings doc.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/6b7d17fb/attachment.sig>
