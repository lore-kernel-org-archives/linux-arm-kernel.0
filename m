From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Oct 2016 20:37:48 +0300
Subject: [PATCH v9 2/2] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <1476811129-4450-3-git-send-email-ayaka@soulik.info>
References: <devicetree@vger.kernel.org>
 <1476811129-4450-1-git-send-email-ayaka@soulik.info>
 <1476811129-4450-3-git-send-email-ayaka@soulik.info>
Message-ID: <20161018173748.GB30003@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 01:18:49AM +0800, Randy Li wrote:
> The TOPEET itop exynos 4412 have three versions base board. The
> Elite version is the cheap one without too much peripheral devices
> on it.
> 
> Currently supported are serial console, wired networking(USB),
> USB OTG in peripheral mode, USB host, SD storage, GPIO buttons,
> PWM beeper, ADC and LEDs. The WM8960 analog audio codec is also
> enabled.
> 
> The FIMC is not used for camera currently, I enabled it just for a
> colorspace converter.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, applied, with missing Rob's ack, minor changes in commit msg and
fix in pin function (you used macro for pull up/down instead of
function).

Best regards,
Krzysztof
