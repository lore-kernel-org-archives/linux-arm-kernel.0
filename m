From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Thu, 18 Dec 2014 11:26:47 +0100
Subject: Weird/Unneeded call to msleep in exynos_mipi_dsi_wr_data in
 exynos_mipi_dsi_common.c
In-Reply-To: <54920A54.2060608@gmail.com>
References: <54920A54.2060608@gmail.com>
Message-ID: <5492ABE7.1060900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.12.2014 23:57, nick wrote:
> Greetings Fellow Maintainers,
> Sorry if I wasting your time but it seems there is a unneeded call to msleep

Hi,

1. Please describe exactly why do you think this is not needed.
2. Do you have Exynos-based hardware to test your changes?

Best regards,
Krzysztof

> and rather trivial fix me to fix in the file,exynos_mipi_dsi_common.c for the function,exynos_mipi_dsi_wr_data . If there is a valid reason for this call please let me known when any of you  have some free time. Otherwise I will send in a patch to remove this unneeded
> call to msleep.
> Thanks,
> Nick  
