From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 Jun 2012 10:04:18 +0200
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <4FD6F15E.4080000@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <4FD658C2.4030503@redhat.com> <4FD6F15E.4080000@free-electrons.com>
Message-ID: <20120612080418.GC3221@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 09:35:58AM +0200, Gregory CLEMENT wrote:
> On 06/11/2012 10:44 PM, David Marlin wrote:
> > 
> > I noticed that you are using mach-mvebu in these patches.  I have seen 
> > these machines referred to as 'armada', 'axp', 'armadaxp', etc.  Will 
> > 'mvebu' be the official machine name to use for these systems?  I'm 
> > looking for a 'name' to identify the common kernel for these systems. 
> > For reference, the names of the ARM kernels we are currently building in 
> > Fedora include: 'highbank', 'imx', 'kirkwood', 'omap', and 'tegra'.
> > 
> > 
> > Thank you,
> > 
> > d.marlin
> > ===========
> > 
> 
> Hello David,
> 
> Mvebu is aimed to be the official name for the all the SOC with device tree
> support coming out of Marvell's EBU division. As stated Nicolas Pitre: "One
> thing that is common to Orion/Kirkwood/Dove/(insert some Armada flavours
> here)/etc though is that they came out of Marvell's EBU division."
> 
> For the beginning only Armada XP and Armada 370 are in this directory but as
> son as the other Marvell architectures will be converted to device tree they
> will be moved to mach-mvebu.

So it still seems like we have a naming issue. We have given a usable
name to the directory. But what do we call the kernel? This is what
David wants to know. When we have moved the DT enabled architectures
into mach-mvebu, they are still likely to build a ARMv5 kernel for
Kirkwood and Orion5x, and a ARMv7 kernel for Dove plus these two new
SoCs. But what do we call this new kernel?

      Andrew
