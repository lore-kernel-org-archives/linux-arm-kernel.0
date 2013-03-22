From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 17:13:21 +0000
Subject: [PULL] VGIC fixes for KVM/ARM
In-Reply-To: <514C86F5.1040102@arm.com>
References: <b06d478e1008aa14c12fa1ea9f8da941@localhost>
 <20130222154136.GD17833@n2100.arm.linux.org.uk>
 <215351192187808fc309b8f9c0541b1c@localhost>
 <20130222191825.GE17833@n2100.arm.linux.org.uk>
 <6db01359033b27c77b5c65f781b458d8@localhost> <514C86F5.1040102@arm.com>
Message-ID: <20130322171321.GF4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 04:29:41PM +0000, Marc Zyngier wrote:
> Hi Russell,
> 
> Any chance this two patches can make it into the next -rc? They do fix a
> couple of important issues (loss of guest interrupts).
> 
> I'm happy to either resend a pull request if you want one, or put them
> in the patch system if that's more convenient.

Gah.  Welcome to the problems of email getting buried... these lists are
currently running at 300 messages per day - this was completely off my
radar.  It's the same old problem - unless I process the email as soon
as I see it, it _will_ get buried and forgotten.

If people can send pull requests for _me_ to linux+pull at arm.linux.org.uk,
I can direct them into a separate mailbox (and know for certain that
they're intending _me_ to pull them) and that will remove the problem
of stuff being buried like this.
