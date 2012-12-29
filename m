From: olof@lixom.net (Olof Johansson)
Date: Fri, 28 Dec 2012 22:39:13 -0800
Subject: [PATCH 6/9] ARM: dt: tegra114: Add new SoC base, Tegra 114 SoC
In-Reply-To: <1355996654-6579-7-git-send-email-hdoyu@nvidia.com>
References: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
 <1355996654-6579-7-git-send-email-hdoyu@nvidia.com>
Message-ID: <20121229063913.GA13620@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 11:44:04AM +0200, Hiroshi Doyu wrote:
> Initial support for Tegra 114 SoC. This is expected to be included in
> the board DTS files, Tegra 114 SoC based evaluation board family.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>

Hi,

I think it could be a good idea to start documenting the cpu configuration in
the device tree on some of these larger platforms as well, i.e. include a cpus/
hierarchy. Would you mind adding those, please?

It would give you the flexibility of switching over to using device
tree to probe the number of cpus in case the platform grows yet another
way to figure out the number of cores in the future, without having to
update the device-trees at that time. :)


-Olof
