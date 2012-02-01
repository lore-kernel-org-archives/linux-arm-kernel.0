From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 1 Feb 2012 12:10:10 +0200
Subject: [PATCH v2 0/8] Add tegra30 support for secondary cores
In-Reply-To: <20120201083334.GM7399@quad.lixom.net>
References: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
 <20120201083334.GM7399@quad.lixom.net>
Message-ID: <20120201101010.GN24948@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 09:33:34AM +0100, Olof Johansson wrote:
> Hi,
> 
> On Tue, Jan 31, 2012 at 06:40:38PM +0200, Peter De Schrijver wrote:
> > This patchset introduces support for secondary cores on tegra30. It also
> > introduces some functions for the flowcontroller and adds basic support for
> > tegra30 powerdomains.
> 
> It would be very useful to get a quick recap of what has changed since
> previous versions in the cover email, if not detailed in the individual
> patches (which it doesn't seem to be).
> 

Oops. I forgot about that. 

Here it is:

Changes in v2:

* moved chip id reading to fuse.c and cleanup code
* don't set bit 1 of SB_CTRL on Tegra20
* removed unused variables in tegra_cpu_reset_handler_init()

Cheers,

Peter.
