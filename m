From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2011 10:49:42 -0800
Subject: [PATCH 01/10] arm/tegra: initial device tree for tegra30
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1740D74C46@HQMAIL01.nvidia.com>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
 <1321546766-26770-2-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D74C46@HQMAIL01.nvidia.com>
Message-ID: <20111118184942.GA31678@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 11:39:14AM -0800, Stephen Warren wrote:
> Peter De Schrijver wrote at Thursday, November 17, 2011 9:19 AM:
> > This patch adds the initial device tree for tegra30
> 
> > diff --git a/Documentation/devicetree/bindings/arm/tegra.txt
> ...
> > +* harmony: tegra20 based development board
> > +Required root node properties:
> > + - compatible = "nvidia,harmony", "nvidia,tegra20";
> > +
> > +* seaboard: tegra20 based clamshell reference design
> > +Required root node properties:
> > + - compatible = "nvidia,seaboard", "nvidia,tegra20";
> 
> Do we really want to list all the board names here? In the future, there
> could be tens or hundreds. I would argue that we should just document
> nvidia,tegra20 and nvidia,tegra30.

Agreed.

> At a later point, we should fix board-dt.c to solely look for those
> compatible values, although this will have to wait until the pinmux DT
> bindings are present. Then, the kernel won't care about the board names.

Exactly.


-Olof
