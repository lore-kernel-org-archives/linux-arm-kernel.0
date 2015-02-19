From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 19 Feb 2015 14:31:26 +0100
Subject: [PATCH v2 1/1] ARM: dts: Add mclk entry for Snow and Peach Pit/Pi
 boards
In-Reply-To: <1423245171-25485-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1423245171-25485-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <54E5E5AE.3080001@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On 02/06/2015 06:52 PM, Javier Martinez Canillas wrote:
> From: Tushar Behera <tushar.b@samsung.com>
> 
> On Snow, Peach Pit and Peach Pi boards, the Exynos SoC XCLKOUT output pin
> provides the master clock (mclk) to codecs. So make them a clock consumer.
> 
> Signed-off-by: Tushar Behera <tushar.b@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 

Please drop this patch since I took it from [0] but that patch was when
the master clock was grabbed in the ASoC machine driver but the final
version that got merged grabs the master clock in the codec driver so
it has to be in the codec device node too.

I'll send the correct version soon.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/5/20/4
