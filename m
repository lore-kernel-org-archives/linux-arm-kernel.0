From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 29 Feb 2012 14:38:16 -0800
Subject: [PATCH v3 00/10] Add tegra30 support for secondary cores
In-Reply-To: <20120229154229.GL12917@tbergstrom-lnx.Nvidia.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB954@HQMAIL01.nvidia.com>
 <20120229154229.GL12917@tbergstrom-lnx.Nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF21F3@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Wednesday, February 29, 2012 8:42 AM:
> On Wed, Feb 15, 2012 at 10:27:43PM +0100, Stephen Warren wrote:
> > Peter De Schrijver wrote at Thursday, February 09, 2012 4:48 PM:
> > > This patchset introduces support for secondary cores on tegra30. It also
> > > introduces some functions for the flowcontroller and adds basic support for
> > > tegra30 powerdomains.
> >
> > The code looks fine to me. I do notice the following when running
> > "shutdown -h now":
> >
> > [   27.762124] SMP: failed to stop secondary CPUs

I can't seem to reproduce this at all on next-20120229 anymore. What
kind of repro frequency are you seeing, and does it get fixed if you
update to that baseline?

(I tried 20 times with shutdown, and 15 of them I reverted all the CPU
and cache errata in case they affected the issue at all)

-- 
nvpublic
