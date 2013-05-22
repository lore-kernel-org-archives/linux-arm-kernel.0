From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 22 May 2013 14:49:36 -0400
Subject: [PATCH v4 06/12] ARM: dove: add gigabit ethernet and mvmdio
 device tree nodes
In-Reply-To: <519D1204.4090701@gmail.com>
References: <519C9333.20609@gmail.com> <519C9822.9040909@windriver.com>
 <519C9A66.3050807@gmail.com>
 <20130522131010.GB31290@titan.lakedaemon.net>
 <20130522165908.GB12320@obsidianresearch.com>
 <519D0143.1000203@gmail.com>
 <20130522173505.GH31290@titan.lakedaemon.net>
 <519D038C.9000605@gmail.com>
 <20130522174815.GI31290@titan.lakedaemon.net>
 <519D1204.4090701@gmail.com>
Message-ID: <20130522184936.GK31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 08:44:20PM +0200, Sebastian Hesselbarth wrote:
> On 05/22/2013 07:48 PM, Jason Cooper wrote:
> >On Wed, May 22, 2013 at 07:42:36PM +0200, Sebastian Hesselbarth wrote:
> >>Hmm, maybe a little bit too early. While restoring the MAC address now
> >>works, another bug arises which I guess is related with phy setup
> >>and aneg.
> >>
> >>Will investigate and update patch set accordingly.
> >
> >Cool, chances are, we should be able to take that patch in by itself for
> >this merge window...
> 
> Which patch do you mean? The local-mac-address workaround will only be
> available for DT mv643xx_eth because it uses the DT node to store the
> MAC.

I thought you were replacing the unconditional ethernet clock grabbing
with reading the mac from the registers and updating the dtb?  In
mach-kirkwood/board-dt.c?

confused. :-/

Jason.
