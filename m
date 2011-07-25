From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 25 Jul 2011 23:20:42 +0100
Subject: [PATCH 0/3] Add device tree based initialisation for VIC
In-Reply-To: <20110725195423.GA26735@ponder.secretlab.ca>
References: <1311610200-12408-1-git-send-email-jamie@jamieiles.com>
	<20110725195423.GA26735@ponder.secretlab.ca>
Message-ID: <20110725222041.GA3001@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 01:54:23PM -0600, Grant Likely wrote:
> On Mon, Jul 25, 2011 at 05:09:57PM +0100, Jamie Iles wrote:
> > This series aims to allow VIC devices to be probed from the device tree.
> > Currently the only in-tree device tree enabled user of the VIC is versatile,
> > but I'll shortly submit patches for picoxcell on device tree that uses 2
> > VIC's.
> > 
> > I've split this into 3 patches for bisectability, but this could be fairly
> > squashed into 2.
> 
> I always prefer fewer patches.  Which 2 patches would you squash
> together?  :-)

The conversion for versatile could go into one patch, but I'm not sure it 
would bisect as easily (I guess that's more important though).

Jamie
