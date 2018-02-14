From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Feb 2018 15:45:05 +0100
Subject: [PATCH -next] clk: samsung: exynos5433: Remove redundant
 dev_err call in exynos5433_cmu_probe()
In-Reply-To: <1516188387-144930-1-git-send-email-weiyongjun1@huawei.com>
References: <1516188387-144930-1-git-send-email-weiyongjun1@huawei.com>
 <CGME20180214144511epcas1p2d950632022f7fbc07151959fc6a43701@epcas1p2.samsung.com>
Message-ID: <a819f423-a283-b30c-b088-b865cea3e6ec@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2018 12:26 PM, Wei Yongjun wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied, thanks.
