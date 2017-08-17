From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 18 Aug 2017 01:09:39 +0300
Subject: [PATCH 5/6] gpu: host1x: Add Tegra186 support
In-Reply-To: <20170817185413.6324-6-mperttunen@nvidia.com>
References: <20170817185413.6324-1-mperttunen@nvidia.com>
 <20170817185413.6324-6-mperttunen@nvidia.com>
Message-ID: <0c2035b6-456a-22a7-0a4a-1d5bf3081927@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.08.2017 21:54, Mikko Perttunen wrote:
> Add support for the implementation of Host1x present on the Tegra186.
> The register space has been shuffled around a little bit, requiring
> addition of some chip-specific code sections. Tegra186 also adds
> several new features, most importantly the hypervisor, but those are
> not yet supported with this commit.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---

I haven't reviewed Tegra186-specific code since I'm not familiar with that
platform. Code movement related to pre-Tegra186 looks fine, no regressions
spotted on Tegra20.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>

-- 
Dmitry
