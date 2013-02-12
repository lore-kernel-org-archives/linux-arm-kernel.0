From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Feb 2013 14:09:51 +0000
Subject: [PATCH] arm: Preserve TPIDRURW on context switch
In-Reply-To: <511A4B93.1000700@dawncrow.de>
References: <5112DC7E.4020108@dawncrow.de>
 <20130206225150.GL17833@n2100.arm.linux.org.uk>
 <5112E0C3.1080706@dawncrow.de>
 <20130208154809.GF3495@mudshark.cambridge.arm.com>
 <511A4B93.1000700@dawncrow.de>
Message-ID: <20130212140950.GC4123@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Tue, Feb 12, 2013 at 02:02:59PM +0000, Andr? Hentschel wrote:
> Am 08.02.2013 16:48, schrieb Will Deacon:
> > On Wed, Feb 06, 2013 at 11:01:23PM +0000, Andr? Hentschel wrote:
> >> No, i'm not sure how to improve this. How does the process can continue, can you or someone else fix that and add his Signed-off-by?
> > 
> > How about something like the (completely untested) diff below?
> > 
> > Andre: if this works for you, I'm happy to write a commit message etc.
> 
> Thx for your effort, but it doesn't work, at least not with my 3.4.6 suse kernel.
> Be free to have another try, i'll be happy to test it.

Well, cheers for testing. Can you be more specific about what goes wrong
please? What do you see in TPIDRURW?

Will
