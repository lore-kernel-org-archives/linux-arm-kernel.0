From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 16 Feb 2012 00:25:51 +0200
Subject: [PATCH v3 00/10] Add tegra30 support for secondary cores
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178FACB954@HQMAIL01.nvidia.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB954@HQMAIL01.nvidia.com>
Message-ID: <20120215222551.GN16501@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 10:27:43PM +0100, Stephen Warren wrote:
> Peter De Schrijver wrote at Thursday, February 09, 2012 4:48 PM:
> > This patchset introduces support for secondary cores on tegra30. It also
> > introduces some functions for the flowcontroller and adds basic support for
> > tegra30 powerdomains.
> 
> The code looks fine to me. I do notice the following when running
> "shutdown -h now":
> 
> [   27.762124] SMP: failed to stop secondary CPUs
> 
> So, this patch series makes the secondary cores boot OK, but not shut
> down it appears. Is that expected? It's probably something we can fix
> with a following on patch rather than re-spinning this series though?
> 

This seems to be a bug indeed. I will look at it next week when I'm back in
finland.

Cheers,

Peter.
