From: msalter@redhat.com (Mark Salter)
Date: Wed, 11 Jan 2012 14:36:21 -0500
Subject: [PATCH 2/2] Kbuild: Use dtc's -d (dependency) option
In-Reply-To: <1326134295-15547-2-git-send-email-swarren@nvidia.com>
References: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
 <1326134295-15547-2-git-send-email-swarren@nvidia.com>
Message-ID: <1326310587.2535.291.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-01-09 at 11:38 -0700, Stephen Warren wrote:
> This hooks dtc into Kbuild's dependency system.
> 
> Thus, for example, "make dtbs" will rebuild tegra-harmony.dtb if only
> tegra20.dtsi has changed yet tegra-harmony.dts has not. The previous
> lack of this feature recently caused me to have very confusing "git
> bisect" results.
> 
> For ARM, it's obvious what to add to $(targets). I'm not familiar enough
> with other architectures to know what to add there. Powerpc appears to
> already add various .dtb files into $(targets), but the other archs may
> need something added to $(targets) to work.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 

Acked-by: Mark Salter <msalter@redhat.com>

For the arch/c6x bit.
