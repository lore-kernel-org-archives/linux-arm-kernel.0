From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 10 Jan 2011 18:57:43 -0500 (EST)
Subject: [PATCH 4/4] ARM: support for Thumb-2 instructions with
	CONFIG_ARM_PATCH_PHYS_VIRT
In-Reply-To: <20110110232435.GF12552@n2100.arm.linux.org.uk>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-5-git-send-email-nico@fluxnic.net>
	<AANLkTi=g+Wf7T60=nLeCpuPtYebZhE5URr4t2T6zzsCC@mail.gmail.com>
	<alpine.LFD.2.00.1101101740280.9794@xanadu.home>
	<20110110232435.GF12552@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101101856320.9794@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jan 2011, Russell King - ARM Linux wrote:

> On Mon, Jan 10, 2011 at 05:45:44PM -0500, Nicolas Pitre wrote:
> > I need to rework this part entirely now anyway to go on top of Russell's 
> > latest version.
> 
> I've made a few changes recently to it to fix a few quirks.  Once the
> merge window is over, I'll push out new patches and tree.  Until then
> it wouldn't be fair on SFR/linux-next to push new code stuff out during
> the merge window.

Maybe you could push those into a branch which is not pulled into 
linux-next?


Nicolas
