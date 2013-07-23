From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 23 Jul 2013 07:07:31 +0000 (UTC)
Subject: OMAP2430 SDP boot broken after Linus' rmk merge
In-Reply-To: <51EE2AA7.5060503@ti.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com>
 <20130722184325.GA21614@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com>
 <51EE2AA7.5060503@ti.com>
Message-ID: <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

On Tue, 23 Jul 2013, Rajendra Nayak wrote:

> On Tuesday 23 July 2013 01:37 AM, Paul Walmsley wrote:
> > On Mon, 22 Jul 2013, Russell King - ARM Linux wrote:
> > 
> >> Bear in mind that I'm almost at the point of not boot-testing anything
> >> I sent to Linus because of the uselessness of the SDP4430 board now
> >> that it's DT only - the only platform which boot-tests anything I send
> >> is the 3430LDP board now.  If people care about that, maybe they can
> >> assist with sorting out the issues I've raised on these lists about
> >> the SDP4430 - and why the SDP4430 build remains disabled in my build
> >> and boot system.
> > 
> > I understand completely...
> > 
> >> Looking at the boot log, it just stops after uboot hands over control.
> >> With the lack of output from the decompressor, it's not possible to
> >> tell whether it's a decompressor problem or a kernel problem.
> >>
> >> I think you need to turn on the LL_DEBUG option, select the appropriate
> >> output option, and also get the decompressor to use the kernel's debug
> >> io functions to output it's stuff (I think the option is DEBUG_UNCOMPRESS).
> > 
> > OK, will dig deeper here at the next opportunity.
> 
> Paul, I can take a look at the 4430sdp issue. Are you also seeing this also on
> 2430sdp as the subject says, or was that a typo?

Thanks for the offer.  The issue that I'm seeing is on the 2430SDP in my 
testbed.

I don't have a 4430SDP, so you might consider touching base with rmk for 
that one.


- Paul
