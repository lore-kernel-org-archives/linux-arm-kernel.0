From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Sep 2017 08:17:06 +0200
Subject: [GIT PULL] Allwinner clock changes for 4.14, take 3
In-Reply-To: <20170831175901.GF21656@codeaurora.org>
References: <20170824083620.b5cq4qtyr3cqtpjx@flea.lan>
 <20170831175901.GF21656@codeaurora.org>
Message-ID: <20170901061706.varrjekvcuymqzx2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Aug 31, 2017 at 10:59:01AM -0700, Stephen Boyd wrote:
> On 08/24, Maxime Ripard wrote:
> > Hi,
> > 
> > Here is a quite late PR, but this also something we've been waiting
> > for for quite some time already.
> > 
> > These patches convert our last users of the old clock framework to the
> > new one. We still have some marginal users of the old clock drivers,
> > but they shouldn't prevent the fix for the orphans clocks we hold back
> > to work.
> > 
> 
> Great. Thanks. Pulled into clk-next.

Just so you know, since we haven't heard from you about this one, we
didn't send the DT bits. So the conversion of our DTs will happen in
4.15.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170901/f167cc8a/attachment.sig>
