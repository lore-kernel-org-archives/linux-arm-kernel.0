From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 1 Jun 2015 06:31:37 +0300
Subject: [PATCH] drm/exynos/ipp: Replace struct timeval usage
In-Reply-To: <20150601031308.GA2785@tinar>
References: <20150601031308.GA2785@tinar>
Message-ID: <20150601033137.GR2282@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tina,

On Mon, Jun 01, 2015 at 08:43:08AM +0530, Tina Ruchandani wrote:
> 'struct timeval' uses a 32-bit seconds representation which
> will overflow in the year 2038 and beyond. This patch
> replaces the use of struct timeval with struct timespec64
> which uses a 64-bit seconds representation and is y2038 safe.
> 
> The patch is part of a larger effort to remove all 32-bit
> timekeeping variables (timeval, time_t and timespec) from the
> kernel.

Your sing-off is missing.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
