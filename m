From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Feb 2013 10:43:16 -0700
Subject: [PATCH] clk: tegra: provide dummy cpu car ops
In-Reply-To: <1360853581-9756-1-git-send-email-pdeschrijver@nvidia.com>
References: <1360853581-9756-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <511D2234.8000408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 07:52 AM, Peter De Schrijver wrote:
> tegra_boot_secondary() relies on some of the car ops. This means having an
> uninitialized tegra_cpu_car_ops will lead to an early boot panic.
> Providing a dummy struct avoids this and makes adding Tegra114 clock support
> in a bisectable way a lot easier.
> 
> --
> 
> Stephen,
> 
> Should this be a separate patch or should I make this part of new release of
> the Tegra114 clock series?

I will try and remember to apply this before the Tegra114 clock series,
although I think you're reposting that anyway, so feel free to include
this in that series to make things simpler.
