From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Oct 2011 21:24:49 +0100
Subject: [PATCH 4/6] arm/tegra: implement support for tegra30
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173E1B49B6@HQMAIL01.nvidia.com>
References: <1319561644-6160-1-git-send-email-pdeschrijver@nvidia.com>
	<1319561644-6160-5-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B49B6@HQMAIL01.nvidia.com>
Message-ID: <20111027202449.GQ19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 01:10:10PM -0700, Stephen Warren wrote:
> Peter De Schrijver wrote at  Tuesday, October 25, 2011 10:54 AM:
> > From: Peter De Schrijver <pdeschrijver@nvidia.com>
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Some description here would be nice.

Definitely - it's something which Andrew Morton commented on during
the kernel summit.  Commit messages really should sell the patch
they're attached to, so that people reading the kernel commit log
(a) have some idea what the patch is doing and (b) why it's being
added.

So maybe something like:

Add support for the Tegra T30 SoC, found in x, y and z.  This
includes a device tree compatible type for this SoC ("nvidia,tegra30")
and adapts the kernels L2 cache initialization for this new SoC.

(That's my best guess based on the contents of this patch.)
