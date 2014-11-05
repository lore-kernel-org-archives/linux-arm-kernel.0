From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Nov 2014 14:40:40 +0100
Subject: [linux-sunxi] Re: [PATCH 3/6] phy: Add driver to support
 individual USB PHYs on sun9i
In-Reply-To: <jwvr3xhu6p3.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
References: <1415074039-16590-1-git-send-email-wens@csie.org>
 <1415074039-16590-4-git-send-email-wens@csie.org>
 <1415081773.665.1.camel@plaes.org>
 <20141105094543.GC27686@lukather>
 <jwvr3xhu6p3.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
Message-ID: <20141105134040.GE27686@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Please keep me in Cc.

On Wed, Nov 05, 2014 at 08:27:41AM -0500, Stefan Monnier wrote:
> > Until some new SoC part of the sun9i family comes up, and it will just
> > add to the confusion.
> 
> Maybe, but then again maybe not.  It depends whether such a new member
> ever shows up, and whether it has a hardware that's compatible enough
> that the code doesn't need to be changed (seems unlikely).

Yeah, and in all cases, we won't be wrong. While if a new SoCs comes
out which is part of the sun9i (let's say A842), you'll have to select
an option that states that it is for the A80.

The list will be confusing for the user and/or a pain to maintain for
us.

> > Such a person would know that the A80 is part of the sun9i family if
> > it has some knowledge of the Allwinner SocS.  And if they don't, A80 or
> > sun9i or both won't make any kind of difference.
> 
> Actually, I'm fairly familiar with Allwinner's family of SoCs, but
> I kind of lost track of which Ann corresponds to which sunXi.  If I got
> a board, all the documentation would tell me that it's got an A80 on
> board, but not that it has a sun9i thingy on board.  So there's a good
> chance that a user knows "A80" but not "sun9i".

Good thing we do have a wiki page just for that then.

http://linux-sunxi.org/Allwinner_SoC_Family#Comparison_table

> And last I heard the sunXi designations are a bit unreliable since
> Allwinner renumbered them differently (is the A20 a sun7i or a sun8i).

It might have been both to Allwinner. It's always been sun7i for us.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/ebe7a30e/attachment.sig>
