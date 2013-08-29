From: jic23@kernel.org (Jonathan Cameron)
Date: Thu, 29 Aug 2013 21:50:31 +0100
Subject: [PATCH v3 3/6] iio: at91: Use different prescal, startup mask
 in MR for different IP
In-Reply-To: <20130828085631.GO2695@lukather>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
 <1377602932-1899-4-git-send-email-josh.wu@atmel.com>
 <20130828085631.GO2695@lukather>
Message-ID: <521FB417.4000005@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/13 09:56, Maxime Ripard wrote:
> Hi Josh,
> 
> 
> On Tue, Aug 27, 2013 at 07:28:49PM +0800, Josh Wu wrote:
>> For at91 boards, there are different IPs for adc. Different IPs has different
>> STARTUP & PRESCAL mask in ADC_MR.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> 
> It looks fine.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Maxime
> 
Note there was some fuzz with this one (because of taking the fix
via the other branch I would guess).  Hence please sanity check
it is fine when you have a minute.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
