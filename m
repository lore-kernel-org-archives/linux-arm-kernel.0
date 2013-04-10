From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Apr 2013 22:04:31 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <yw1x61zu866d.fsf@unicorn.mansr.com>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <yw1xmwt68whw.fsf@unicorn.mansr.com>
 <20130410114229.GH14496@n2100.arm.linux.org.uk>
 <yw1xip3u8uni.fsf@unicorn.mansr.com>
 <20130410185421.GI14496@n2100.arm.linux.org.uk>
 <yw1xehei8a19.fsf@unicorn.mansr.com>
 <20130410200344.GO14496@n2100.arm.linux.org.uk>
 <yw1x61zu866d.fsf@unicorn.mansr.com>
Message-ID: <20130410210431.GQ14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 09:46:50PM +0100, M?ns Rullg?rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > Oh fuck off, just really fuck off you total dickface.  Really, do you
> > think that I, being the one who created the VFP support code, haven't
> > read the VFP documentation?  Christ, you are fucking thick.
> 
> I'll ignore the insults for now, but you really should consider watching
> your tone if you want to be taken seriously.

Really?  After you accused me of not reading the documentation?  What
planet are you on?  Planet lunacy?  *You* need to learn some bloody
respect.

> > Subarchitecture, bits [22:16]
> > 0b0000011
> > VFP architecture v3 or later with Null subarchitecture. The entire floating-point
> > implementation is in hardware, and no software support code is required. The
> > VFP architecture version is indicated by the MVFR0 and MVFR1 registers.
> > This value can be used only by an implementation that does not support the trap
> > enable bits in the FPSCR, see Floating-point Status and Control Register
> > (FPSCR) on page A2-28.
> 
> This means merely that the implementation never traps on things like
> denormal inputs or over/underflow.  It has nothing to do with vector
> support.

Wrong.  The VFP subarchitecture defines the interface between *VFP
hardware* and the *VFP support code*.  I suggest you read carefully the
chapter in the ARM ARM *before* you make any further comment, and make
yourself look any more a fool than you already do.
