From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Feb 2018 15:43:34 +0100
Subject: [PATCH -next] clk: samsung: exynos-audss: Remove redundant
 dev_err call in exynos_audss_clk_probe()
In-Reply-To: <1516188378-144847-1-git-send-email-weiyongjun1@huawei.com>
References: <1516188378-144847-1-git-send-email-weiyongjun1@huawei.com>
 <CGME20180214144350epcas1p1d66e605e6d68de23661f51ced410d72e@epcas1p1.samsung.com>
Message-ID: <240b9be5-429c-ca34-63c6-bdd260970ca8@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2018 12:26 PM, Wei Yongjun wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied, thanks.
