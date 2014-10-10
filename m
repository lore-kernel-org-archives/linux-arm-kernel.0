From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Oct 2014 15:56:43 +0200
Subject: [PATCH v4] ARM: sun7i: add support for A20-OLinuXino-Lime2
In-Reply-To: <5437DC04.6070000@gmail.com>
References: <20140928164337.GB15315@lukather> <54295711.9010901@gmail.com>
 <20140929132543.GC4081@lukather> <54296D8B.3080304@gmail.com>
 <20141002124807.GC4039@lukather> <5431C8EF.3070809@gmail.com>
 <20141006092049.GF4090@lukather> <54366326.3060303@gmail.com>
 <20141009195630.GJ19438@lukather> <5437DC04.6070000@gmail.com>
Message-ID: <20141010135643.GN19438@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 02:15:48PM +0100, Iain Paton wrote:
> On 09/10/14 20:56, Maxime Ripard wrote:
> > Hi Iain,
> > 
> > On Thu, Oct 09, 2014 at 11:27:50AM +0100, Iain Paton wrote:
> >> This adds support for the Olimex A20-OLinuXino-Lime2
> >> https://www.olimex.com/Products/OLinuXino/A20/A20-OLinuXIno-LIME2
> >>
> >> Differences to previous Lime boards are 1GB RAM and gigabit ethernet
> >>
> >> Signed-off-by: Iain Paton <ipaton0@gmail.com>
> > 
> > Sorry for noticing this so late, but we sort the DT nodes by their
> > base address. Could you respin this for another version?
> 
> Sure, no problem, on it's way shortly.
> 
> Is there any general rule for this sort of thing, or is this something 
> specific to sunxi?   
> 
> Asking mainly as I've been asked to do them alphabetically previously 
> by a different maintainer and that's esentially why I did it the same 
> way here.
> 
> Everyone having different undocumented conventions seems likely to 
> become counter productive eventually.

That's unusual, it should be a global convention at least for ARM.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/6ff496e6/attachment-0001.sig>
