From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Apr 2016 18:56:14 +0200
Subject: [PATCH v3 04/19] clk: sunxi: Add TCON channel1 clock
In-Reply-To: <20160415223936.GU14441@codeaurora.org>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-5-git-send-email-maxime.ripard@free-electrons.com>
 <20160415223936.GU14441@codeaurora.org>
Message-ID: <20160421165614.GR13045@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 03:39:36PM -0700, Stephen Boyd wrote:
> On 03/23, Maxime Ripard wrote:
> > The TCON is a controller generating the timings to output videos signals,
> > acting like both a CRTC and an encoder.
> > 
> > It has two channels depending on the output, each channel being driven by
> > its own clock (and own clock controller).
> > 
> > Add a driver for the channel 1 clock.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160421/2a0917b5/attachment.sig>
