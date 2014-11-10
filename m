From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Nov 2014 15:07:04 +0100
Subject: [PATCH] ARM: Wire up bpf syscall
In-Reply-To: <20141110140228.GX4042@n2100.arm.linux.org.uk>
References: <1415627996-27395-1-git-send-email-thierry.reding@gmail.com>
 <20141110140228.GX4042@n2100.arm.linux.org.uk>
Message-ID: <20141110140702.GA27835@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 02:02:28PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 10, 2014 at 02:59:56PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Add the bpf syscall to ARM.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Note that I haven't tested whether this new syscall actually works on ARM,
> > but it certainly gets rid of the annoying "syscall bpf not implemented"
> > warning.
> 
> I guess you're using an old kernel... the commit adding this is already
> merged - v3.18-rc3~4^2~4

Indeed, I had just realized that I had been working on a branch with an
out-dated base and was going to ask you to disregard this patch.

Sorry for the noise,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/945f310d/attachment.sig>
