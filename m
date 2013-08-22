From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 23 Aug 2013 01:00:43 +0200
Subject: [PATCH] arm: dts: fix NTC thermistor device nodes for cros5250
In-Reply-To: <1377172114-8312-1-git-send-email-ch.naveen@samsung.com>
References: <1377172114-8312-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <2011021.bJnpdqp6MA@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

On Thursday 22 of August 2013 17:18:34 Naveen Krishna Chatradhi wrote:
> This patch fixes NTC devices nodes connected to ADC channel 3, 4, 5 and
> 6 on exynos5250 based snow device.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/boot/dts/cros5250-common.dtsi |   33
> ++++++++++++++++++++++++++++++++ 1 file changed, 33 insertions(+)

This patch does not look like fixing anything. Instead it adds board 
specific data to adc node to cros5250 common dtsi file.

Also please resend this patch with all the recipients added according to 
MAINTAINERS file.

Best regards,
Tomasz
