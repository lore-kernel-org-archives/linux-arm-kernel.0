From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Oct 2018 01:57:21 -0700
Subject: [PATCH 3/3] mfd: ti-lmu: use of_device_get_match_data() helper
In-Reply-To: <20180911210650.GC32497@amd>
References: <20180911210133.GA32497@amd> <20180911210344.GB32497@amd>
 <20180911210650.GC32497@amd>
Message-ID: <20181009085721.GC4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2018, Pavel Machek wrote:

> Replace of_match_device() with of_device_get_match_data(), which
> slightly decreases lines of code and allows to move the DT table
> next to the I2C table.
>     
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Not sure how you're sending these patches, but for future reference
`git send-email` is usually preferred.

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
