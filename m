From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 09 Jul 2014 22:42:25 +0200
Subject: a case for a common efuse API?
In-Reply-To: <53BC4DD7.20906@codeaurora.org>
References: <53BC4DD7.20906@codeaurora.org>
Message-ID: <53BDA931.5010600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 08.07.2014 22:00, Stephen Boyd wrote:
> Hi,
> 
> On MSM chips we have some efuses (called qfprom) where we store things
> like calibration data, speed bins, etc. We need to read out data from
> the efuses in various drivers like the cpufreq, thermal, etc. This
> essentially boils down to a bunch of readls on the efuse from a handful
> of different drivers.

We have similar thing on Exynos SoCs as well. If you're interested in
looking at our use cases, then there was an RFC series posted quite a
long time ago [1], but then things stalled.

[1] https://lkml.org/lkml/2013/11/15/155

Best regards,
Tomasz
