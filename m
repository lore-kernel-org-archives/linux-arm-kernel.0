From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 04 Aug 2015 15:02:47 +0200
Subject: [PATCH v9 0/9] Add simple NVMEM Framework via regmap.
In-Reply-To: <1437995567-11203-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1437995567-11203-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438693367.3793.29.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

Am Montag, den 27.07.2015, 12:12 +0100 schrieb Srinivas Kandagatla:
> Hi Greg/Kevin,
> 
> This patchset adds a new simple NVMEM framework to kernel, and it is tested
> with various drivers like "QCOM thermal sensors", "QCOM cpr driver",
> "begal bone cape manager" and few more on the way.

Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
using the i.MX6 OCOTP shadow register range.

regards
Philipp
