From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Jan 2014 09:18:09 +0100
Subject: [PATCH v2 RESEND] vt8500: pinctrl: Change devicetree data parsing
In-Reply-To: <1390467453-8841-1-git-send-email-linux@prisktech.co.nz>
References: <1390467453-8841-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CACRpkdaUJkTrT1=VST76dSxFhkJYhB6hMM_TRkTCYaX58QHp6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 9:57 AM, Tony Prisk <linux@prisktech.co.nz> wrote:

> Due to an assumption in the VT8500 pinctrl driver, the value passed
> from devicetree for 'wm,pull' was not explicitly translated before
> being passed to pinconf.
>
> Since v3.10, changes to 'enum pin_config_param', PIN_CONFIG_BIAS_PULL_(UP/DOWN)
> no longer map 1-to-1 with the expected values in devicetree.
>
> This patch adds a small translation between the devicetree values (0..2)
> and the enum pin_config_param equivalent values.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
> v2:

Patch applied to fixes and tagged for stable v3.10+

Yours,
Linus Walleij
