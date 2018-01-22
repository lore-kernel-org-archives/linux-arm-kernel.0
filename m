From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 22 Jan 2018 15:09:48 -0800
Subject: [PATCH -next] hwrng: bcm2835 - Remove redundant dev_err call in
 bcm2835_rng_probe()
In-Reply-To: <1516189234-11957-1-git-send-email-weiyongjun1@huawei.com>
References: <1516189234-11957-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <2f6aedf1-4712-73b9-6012-349cdcc2605a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2018 03:40 AM, Wei Yongjun wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
