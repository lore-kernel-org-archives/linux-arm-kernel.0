From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Jan 2015 10:59:40 -0800
Subject: [PATCH v2] arm64: Kconfig: clean up two no-op Kconfig options
 from CONFIG_ARCH_TEGRA*
In-Reply-To: <20150129163137.GJ8951@e104818-lin.cambridge.arm.com>
References: <alpine.DEB.2.02.1501291541390.16475@utopia.booyaka.com>
 <20150129163137.GJ8951@e104818-lin.cambridge.arm.com>
Message-ID: <20150129185940.GC18628@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 04:31:38PM +0000, Catalin Marinas wrote:
> On Thu, Jan 29, 2015 at 03:42:45PM +0000, Paul Walmsley wrote:
> > 
> > Paul Bolle pointed out that commit
> > d035fdfa27ac124bc8f94c3d7dc82ad069802170 ("arm64: Add Tegra132
> > support") included two Kconfig symbols that are now no-ops:
> > USB_ARCH_HAS_EHCI and HAVE_SMP.  So, drop the two symbols.
> > 
> > This second version corrects a thinko in Paul Bolle's E-mail address.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Paul Walmsley <pwalmsley@nvidia.com>
> > Cc: Allen Martin <amartin@nvidia.com>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Paul Bolle <pebolle@tiscali.nl>
> 
> The patch looks fine. Cc'ing the arm-soc guys as they have merged the
> original commit.

Thanks, applied.


-Olof
