From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 31 Dec 2012 08:12:05 +0100
Subject: [PATCH 6/9] ARM: dt: tegra114: Add new SoC base, Tegra 114 SoC
In-Reply-To: <20121229063913.GA13620@quad.lixom.net>
References: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com><1355996654-6579-7-git-send-email-hdoyu@nvidia.com><20121229063913.GA13620@quad.lixom.net>
Message-ID: <20121231.091205.1954307462967637866.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Olof Johansson <olof@lixom.net> wrote @ Sat, 29 Dec 2012 07:39:13 +0100:

> On Thu, Dec 20, 2012 at 11:44:04AM +0200, Hiroshi Doyu wrote:
> > Initial support for Tegra 114 SoC. This is expected to be included in
> > the board DTS files, Tegra 114 SoC based evaluation board family.
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> 
> Hi,
> 
> I think it could be a good idea to start documenting the cpu configuration in
> the device tree on some of these larger platforms as well, i.e. include a cpus/
> hierarchy. Would you mind adding those, please?

Ok, I'll.

> It would give you the flexibility of switching over to using device
> tree to probe the number of cpus in case the platform grows yet another
> way to figure out the number of cores in the future, without having to
> update the device-trees at that time. :)
> 
> 
> -Olof
