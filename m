From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 May 2016 08:36:18 +0200
Subject: [PATCH v4 01/11] clk: sunxi: Add display and TCON0 clocks driver
In-Reply-To: <20160509223924.GX3492@codeaurora.org>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
 <1461590572-4027-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160506223002.GE3492@codeaurora.org>
 <20160508200308.GF6167@lukather>
 <20160509223238.GW3492@codeaurora.org>
 <20160509223924.GX3492@codeaurora.org>
Message-ID: <20160510063618.GI3733@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, May 09, 2016 at 03:39:24PM -0700, Stephen Boyd wrote:
> On 05/09, Stephen Boyd wrote:
> > 
> > Ok I applied this one to clk-next.
> > 
> 
> And I squashed this in to silence the following checker warning.
> 
> drivers/clk/sunxi/clk-sun4i-display.c:110:33: warning: Variable
> length array is used.

Thanks, just out of curiosity, which checker are you talking about?
sparse?

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160510/88855f6a/attachment.sig>
