From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 18:06:56 +0100
Subject: [PATCH v2] ARM: sunxi: dt: Fix aliases
In-Reply-To: <1421961054-30341-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1421961054-30341-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150125170656.GN8470@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 10:10:54PM +0100, Maxime Ripard wrote:
> Commit f77d55a3b56a ("serial: 8250_dw: get index of serial line from DT
> aliases") made the serial driver now use the serial aliases to get the tty
> number, pointing out that our aliases have been wrong all along.
> 
> Remove them from the DTSI and add custom ones in the relevant boards.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/438296c0/attachment.sig>
