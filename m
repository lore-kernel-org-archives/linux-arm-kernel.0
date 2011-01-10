From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jan 2011 23:24:35 +0000
Subject: [PATCH 4/4] ARM: support for Thumb-2 instructions with
	CONFIG_ARM_PATCH_PHYS_VIRT
In-Reply-To: <alpine.LFD.2.00.1101101740280.9794@xanadu.home>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-5-git-send-email-nico@fluxnic.net>
	<AANLkTi=g+Wf7T60=nLeCpuPtYebZhE5URr4t2T6zzsCC@mail.gmail.com>
	<alpine.LFD.2.00.1101101740280.9794@xanadu.home>
Message-ID: <20110110232435.GF12552@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 05:45:44PM -0500, Nicolas Pitre wrote:
> I need to rework this part entirely now anyway to go on top of Russell's 
> latest version.

I've made a few changes recently to it to fix a few quirks.  Once the
merge window is over, I'll push out new patches and tree.  Until then
it wouldn't be fair on SFR/linux-next to push new code stuff out during
the merge window.
