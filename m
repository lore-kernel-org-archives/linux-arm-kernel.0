From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 30 Jul 2016 07:20:02 +0200
Subject: [PATCH 2/3] mmc: sunxi: Set the 'New Timing' register for 8
 bits DDR transfers
In-Reply-To: <20160729193634.GA27116@lukather>
References: <cover.1469082481.git.moinejf@free.fr>
 <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
 <20160721085615.GG5993@lukather>
 <20160721112655.941b1dad04f7a5b94d4172c1@free.fr>
 <20160729193634.GA27116@lukather>
Message-ID: <20160730072002.4aec7254bca2d6ee2013ac0c@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jul 2016 21:36:34 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Thu, Jul 21, 2016 at 11:26:55AM +0200, Jean-Francois Moine wrote:
> > On Thu, 21 Jul 2016 10:56:15 +0200
> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > 
> > > On Wed, Jul 20, 2016 at 08:16:28PM +0200, Jean-Francois Moine wrote:
> > > > The 'new timing mode' with 8 bits DDR works correctly when the NewTiming
> > > > register is set.
> > > 
> > > What does that mode brings to the table?
> > 
> > From my tests, the eMMC of the Banana Pi M3 (A83T) cannot work when the
> > new mode is not used.
> 
> That's odd. The one in the Pine64 seems to work just fine, and yet
> there's only the new mode on the A64.

I spent 2 weeks on this problem. You may try it by yourself.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
