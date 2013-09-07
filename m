From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 7 Sep 2013 12:45:12 +0200
Subject: Inte IOP Xscale updates
In-Reply-To: <20130903134516.GH6617@n2100.arm.linux.org.uk>
References: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
 <20130903134516.GH6617@n2100.arm.linux.org.uk>
Message-ID: <21035.952.938696.169280@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Tue, Sep 03, 2013 at 02:01:45PM +0200, Linus Walleij wrote:
 > > Hi XScale folks,
 > > 
 > > I haven't really seen any functional patches or confirmation that the
 > > XScale machines in arch/arm/iop* are even booting since 2010 or
 > > so.
 > > 
 > > Can you confirm that you boot-test these machines regularly?
 > > 
 > > I am worried that we maintain code that is not used or even working
 > > see.
 > > 
 > > What are your thought about multiplatform and device tree? I am
 > > pretty certain that if the iop machines were converted to device tree
 > > we could collapse these machines into one directory with few files,
 > > but I may be wrong.
 > 
 > Just because code doesn't get touched doesn't mean it doesn't work.  In
 > some cases, that means that the code has reached stability.
 > 
 > The IOP platforms are in regular use.  IOP platforms include such
 > things as TheCUS machines such as the N2100 and others.  The two N2100s
 > I have here run 3.1.8 and 3.9.5.

I just booted 3.9, 3.10, and 3.11 on my N2100, without problems.

Compared to the Kirkwood Qnaps the N2100 is quite slow and noisy,
so I haven't actually used mine in years.

As long as they doesn't cause any maintenance problems I think we
should just leave the IOP platforms as-is.
