From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Sep 2017 15:08:54 +0200
Subject: [PATCH v2 1/2] ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for
 LAN8710
In-Reply-To: <1503901963-9457-2-git-send-email-stefan@olimex.com>
References: <1503901963-9457-1-git-send-email-stefan@olimex.com>
 <1503901963-9457-2-git-send-email-stefan@olimex.com>
Message-ID: <20170901130854.iasjz4eqsvkt6r6z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 09:32:42AM +0300, Stefan Mavrodiev wrote:
> From revision J the board uses new phy chip LAN8710. Compared
> with RTL8201, RA17 pin is TXERR. It has pullup which causes phy
> not to work. To fix this PA17 is muxed with GMAC function. This
> makes the pin output-low.
> 
> This patch is compatible with earlier board revisions, since this
> pin wasn't connected to phy.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Applied for 4.15, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170901/21e85cd8/attachment.sig>
