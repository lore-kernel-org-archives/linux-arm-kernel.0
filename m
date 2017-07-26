From: digetx@gmail.com (Dmitry Osipenko)
Date: Wed, 26 Jul 2017 23:56:58 +0300
Subject: [PATCH 3/4] iommu/tegra-gart: Add iommu_group support
In-Reply-To: <9c3fa9661e8177f0ccea960dd584a05fc19f92c8.1500637633.git.robin.murphy@arm.com>
References: <cover.1500637633.git.robin.murphy@arm.com>
 <9c3fa9661e8177f0ccea960dd584a05fc19f92c8.1500637633.git.robin.murphy@arm.com>
Message-ID: <e1de80c6-33fd-6bd5-bc28-8b3d3043ca4f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.07.2017 15:12, Robin Murphy wrote:
> As the last step to making groups mandatory, clean up the remaining
> drivers by adding basic support. Whilst it may not perfectly reflect the
> isolation capabilities of the hardware, using generic_device_group()
> should at least maintain existing behaviour with respect to the API.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/tegra-gart.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Tested-by: Dmitry Osipenko <digetx@gmail.com>

-- 
Dmitry
