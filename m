From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Feb 2018 12:55:04 -0700
Subject: [PATCH] ARM: dtc: tegra: enable front panel leds in TrimSlice
In-Reply-To: <20180219201623.6987-1-tmn505@gmail.com>
References: <20180219201623.6987-1-tmn505@gmail.com>
Message-ID: <57945bd2-d8c2-f7bc-f01f-29d679762446@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2018 01:16 PM, Tomasz Maciej Nowak wrote:
> Adds device nodes for two front panel LEDs.

Why do you need to change the pinmux settings? Configuring a pin as a 
GPIO should override any pinmux special function selection and hence 
make it irrelevant, so I don't think you should need to change the pinmux.
