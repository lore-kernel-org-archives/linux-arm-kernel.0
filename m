From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 May 2016 22:03:08 +0200
Subject: [PATCH v4 01/11] clk: sunxi: Add display and TCON0 clocks driver
In-Reply-To: <20160506223002.GE3492@codeaurora.org>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
 <1461590572-4027-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160506223002.GE3492@codeaurora.org>
Message-ID: <20160508200308.GF6167@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, May 06, 2016 at 03:30:02PM -0700, Stephen Boyd wrote:
> On 04/25, Maxime Ripard wrote:
> > The A10 SoCs and its relatives has a special clock controller to drive the
> > display engines (both frontend and backend), that have a lot in common with
> > the clock to drive the first TCON channel.
> > 
> > Add a driver to support both.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Unless I can merge this into clk-next? Wasn't clear to me.

Yes, please do, I already sent you the bunch of patches I gathered for
4.7, and I don't have any others but this one.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160508/fe3ce1e7/attachment.sig>
