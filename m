From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 02 Apr 2014 16:05:25 -0700
Subject: [PATCH v7 0/3] Exynos 5410 support
In-Reply-To: <1393213435-20863-1-git-send-email-t.dakhran@samsung.com> (Tarek
 Dakhran's message of "Mon, 24 Feb 2014 12:43:52 +0900")
References: <1393213435-20863-1-git-send-email-t.dakhran@samsung.com>
Message-ID: <7h7g772uyy.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarek Dakhran <t.dakhran@samsung.com> writes:

> The series of patches represent support of Exynos 5410 SoC
>
> The Exynos 5410 is the first Samsung SoC based on bigLITTLE architecture
>
> Patches add new platform description, support of clock controller and device 
> tree for Exynos 5410.
>
> Has been build on Linux Kernel v3.14-rc1 (Samsung kernel,
> 	for-next branch,
> 	commit aaeeda6f57833c7c0e16fef3d76205f36882c21b,
> 	"Merge branch 'v3.15-next/cleanup-samsung' into for-next")
> Has been tested on Exynos 5410 reference board (exynos_defconfig)
>
> I hope, this is enough clean and hasn't any dependencies to go through 
> Samsung tree.

FWIW: boot tested on Exynos 5410 odroid-xu.

Tested-by: Kevin Hilman <khilman@linaro.org>

What's the status of this being queued up for upstream?  Looks like it
just needs to be broken up in to a drivers/clk pull request and a
arm-soc pull request.

Kevin
