From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 20 Oct 2014 17:48:01 +0000 (UTC)
Subject: Tegra baseline test results for v3.18-rc1
In-Reply-To: <alpine.DEB.2.02.1410201415580.4472@utopia.booyaka.com>
References: <alpine.DEB.2.02.1410201415580.4472@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1410201747290.4472@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Oct 2014, Paul Walmsley wrote:

> The 64MiB decrease in highmem is a bit mysterious.  Am thinking that it is 
> probably PCIe-related [...]

It's highmem-related - the CMA area now allocates from highmem.


- Paul
