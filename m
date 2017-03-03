From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 3 Mar 2017 08:12:55 +0100
Subject: [PATCH] clk: sunxi-ng: sun5i: Fix mux width for csi clock
In-Reply-To: <20170302205527.23007-1-plaes@plaes.org>
References: <20170302205527.23007-1-plaes@plaes.org>
Message-ID: <20170303071255.i4lle7thsyhcpj3x@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 10:55:27PM +0200, Priit Laes wrote:
> Mux for CSI clock is 3 bits, not 2.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170303/bdd58adb/attachment.sig>
