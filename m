From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Sep 2014 10:35:59 +0200
Subject: [PATCH] clk: samsung: exynos3250: fix mout_cam_blk parent list
In-Reply-To: <540EF177.8090005@samsung.com>
References: <1410008613-20861-1-git-send-email-pankaj.dubey@samsung.com>
 <540EF177.8090005@samsung.com>
Message-ID: <541FDF6F.6090903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.09.2014 14:24, Krzysztof Koz?owski wrote:
> On 06.09.2014 15:03, Pankaj Dubey wrote:
>> As per user manual of Exynos3250 SRC_CAM can select
>> div_cam_blk_320 if it's value is 0xC, so placing
>> div_cam_blk_320 at proper index in parent list of mout_cam_blk.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos3250.c |    1 +
>>   1 file changed, 1 insertion(+)
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied for next.

Best regards,
Tomasz
