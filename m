From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Oct 2015 08:58:59 +0200
Subject: [PATCH 1/5] ARM: sunxi: Add R8 support
In-Reply-To: <20150930223829.GG18556@codeaurora.org>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442566130-3497-2-git-send-email-maxime.ripard@free-electrons.com>
 <20150930223829.GG18556@codeaurora.org>
Message-ID: <20151001065859.GA7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 03:38:29PM -0700, Stephen Boyd wrote:
> On 09/18, Maxime Ripard wrote:
> > The R8 is a new Allwinner SoC based on the A13. While both are very
> > similar, there's still a few differences. Introduce a new compatible to
> > deal with them.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> BTW, why is the entire series sent To: Mike and I? Are these
> patches intended to go through clk tree?

I wanted to have the Ack from one of you on this patch. I usually
prefer to have the whole serie instead of a single out of context
patch, just let me know if you feel otherwise :)

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/a57c81af/attachment.sig>
