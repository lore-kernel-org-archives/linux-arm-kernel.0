From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 09 Jul 2014 14:42:25 +0200
Subject: [PATCH v2] ARM: EXYNOS: add Exynos3250 PMU support
In-Reply-To: <2933359.zRXLcIi25R@amdc1032>
References: <2933359.zRXLcIi25R@amdc1032>
Message-ID: <1640080.ftkUyQnINn@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 09, 2014 02:39:14 PM Bartlomiej Zolnierkiewicz wrote:
> This is needed for suspend/resume and cpuidle AFTR mode support.
> 
> Cc: Pankaj Dubey <pankaj.dubey@samsung.com>
> Cc: Vikas Sajjan <vikas.sajjan@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

Changelog for v2:

- rebased on top of next-20140708 and
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32410.html
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33660.html
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33675.html

  this patchset also applies fine after/before Exynos5800 PMU support:
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg33835.html

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
