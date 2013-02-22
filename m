From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Feb 2013 15:41:36 +0000
Subject: [PULL] VGIC fixes for KVM/ARM
In-Reply-To: <b06d478e1008aa14c12fa1ea9f8da941@localhost>
References: <b06d478e1008aa14c12fa1ea9f8da941@localhost>
Message-ID: <20130222154136.GD17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 02:58:12PM +0100, Marc Zyngier wrote:
> Arnd, Olof,
> 
> Please find below a pull request for a couple of fixes concerning
> the VGIC implementation in KVM. No real hurry, these can probably
> be applied after the merge window.
> 
> The branch is on top of mainline as of this morning, but I'm happy
> to rebase it on something else if that's more convenient.

Now, why is this being thrown at arm-soc?  Is it not core ARM stuff,
or is KVM being counted as yet another platform?
