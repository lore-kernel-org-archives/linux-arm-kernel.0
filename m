From: robherring2@gmail.com (Rob Herring)
Date: Mon, 2 Dec 2013 23:44:41 -0600
Subject: [PATCH] hwmon: ntc_thermistor: Fix typo (pullup-uV -> pullup-uv)
In-Reply-To: <1382492690-4056-1-git-send-email-cw00.choi@samsung.com>
References: <1382492690-4056-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAL_JsqLQaAJiaCYh3=NyEM7h02z_UCmeX8q_L-Cguj==F9pfbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 8:44 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch fix typo of property name from 'pullup-uV' to 'pullup-uv'.
> The ntc_thermistor.c use 'pullup-uv' when parsing dt data.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied for 3.13.

Rob
