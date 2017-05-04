From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 5 May 2017 00:07:21 +0200
Subject: [PATCH V4] ARM64: dts: hi6220-hikey: Add clock binding for the
 pmic mfd
In-Reply-To: <1493066439-6889-1-git-send-email-daniel.lezcano@linaro.org>
References: <1493066439-6889-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20170504220721.GB5252@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 10:40:22PM +0200, Daniel Lezcano wrote:
> The hi655x PMIC provides the regulators but also a clock. The latter is missing
> in the definition and in the DT, thus it is no possible to enable the WiFi which
> depends on this clock.
> 
> The hi655x's clock has been added and the hi655x multifunction driver has
> updated with a clock-cell.
> 
> This patch adds the clock-cells for the PMIC in the DT and updates the
> documentation.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> ---
>  Changelog:
> 	v4:
> 	   - Added Acked-by's
> 	   - Updated the commit message with a better description
> ---

Hi Xu Wei,

a gentle reminder for this patch. Is it ok for you?

Thanks.

  -- Daniel
