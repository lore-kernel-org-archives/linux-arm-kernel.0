From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Jul 2016 21:36:34 +0200
Subject: [PATCH 2/3] mmc: sunxi: Set the 'New Timing' register for 8 bits
 DDR transfers
In-Reply-To: <20160721112655.941b1dad04f7a5b94d4172c1@free.fr>
References: <cover.1469082481.git.moinejf@free.fr>
 <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
 <20160721085615.GG5993@lukather>
 <20160721112655.941b1dad04f7a5b94d4172c1@free.fr>
Message-ID: <20160729193634.GA27116@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 11:26:55AM +0200, Jean-Francois Moine wrote:
> On Thu, 21 Jul 2016 10:56:15 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Wed, Jul 20, 2016 at 08:16:28PM +0200, Jean-Francois Moine wrote:
> > > The 'new timing mode' with 8 bits DDR works correctly when the NewTiming
> > > register is set.
> > 
> > What does that mode brings to the table?
> 
> From my tests, the eMMC of the Banana Pi M3 (A83T) cannot work when the
> new mode is not used.

That's odd. The one in the Pine64 seems to work just fine, and yet
there's only the new mode on the A64.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160729/e29fe3f0/attachment.sig>
