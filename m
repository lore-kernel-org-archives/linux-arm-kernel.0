From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Apr 2013 22:46:51 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410104002.GF14496@n2100.arm.linux.org.uk>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
Message-ID: <20130410214650.GU14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 11:40:02AM +0100, Russell King - ARM Linux wrote:
> I have just committed a patch to remove the arch/arm/nwfpe code from
> the kernel, and the VFP code emulating the FP operations.

It seems that Linus wishes to fight against this, so we'll just have to
wait and see what happens.  Linus is saying that he's perfectly happy
that the licenses _are_ compatible irrespective of what the FSF say.
