From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 May 2014 09:58:04 +0900
Subject: [PATCH v8 0/3] Exynos 5410 support
In-Reply-To: <7hppk5f26g.fsf@paris.lan>
References: <1397459860-21869-1-git-send-email-t.dakhran@samsung.com>
 <7hppk5f26g.fsf@paris.lan>
Message-ID: <019101cf72fd$644883c0$2cd98b40$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote:
> 
> Tarek Dakhran <t.dakhran@samsung.com> writes:
> 
> > The series of patches represent support of Exynos 5410 SoC
> >
> > The Exynos 5410 is the first Samsung SoC based on bigLITTLE architecture
> >
> > Patches add new platform description, support of clock controller and
> device
> > tree for Exynos 5410.
> >
> > Has been build on Linux Kernel v3.15-rc1
> > Has been tested on: 1) Exynos 5410 reference board (exynos_defconfig)
> > 		    2) Odroid-XU board (exynos_defconfig)
> 
Hi all,

Sorry for late response...

> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
Kevin,

Thanks for your test :-)

[...]

Tarek, can you please re-spin this series based on my current for-next
because some common stuff has been changed?

Thanks,
Kukjin
