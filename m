From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Jan 2017 17:32:24 +0000
Subject: [PATCH v3 0/5] boot-wrapper: arm64: Xen support
In-Reply-To: <20161215122718.21422-1-andre.przywara@arm.com>
References: <20161215122718.21422-1-andre.przywara@arm.com>
Message-ID: <20170103173224.GD14183@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 12:27:13PM +0000, Andre Przywara wrote:
> These patches allow to include a Xen hypervisor binary into a boot-wrapper
> ELF file, so that a Foundation Platform or a Fast Model can boot a Xen
> system (including a Dom0 kernel).

Thanks!

I've applied the series and pushed it out to git.kernel.org.

I made minor tweaks to patches 1 and 3 for consistency, as noted in the
commit logs, but neither of these should have a functional impact.

Thanks,
Mark.
