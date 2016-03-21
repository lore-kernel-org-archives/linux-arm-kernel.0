From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Mar 2016 19:22:24 +0100
Subject: [linux-sunxi][PATCH v2 1/5] clk: sunxi: mod1 clock should modify
 it's parent
In-Reply-To: <1458576642-4078-2-git-send-email-codekipper@gmail.com>
References: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
 <1458576642-4078-2-git-send-email-codekipper@gmail.com>
Message-ID: <20160321182224.GI30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 05:10:38PM +0100, codekipper at gmail.com wrote:
> From: Andrea Venturi <ennesimamail.av@gmail.com>
> 
> add CLK_SET_RATE_PARENT to modify the rate on clk upstream
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Applied, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/2ef8404e/attachment.sig>
