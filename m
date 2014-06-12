From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Jun 2014 13:45:27 -0600
Subject: [PATCH v2 3/3] arm: tegra: initial support for apalis t30
In-Reply-To: <95c131deb3e410e8defc9fe125dc662bdb276310.1402353627.git.marcel@ziswiler.com>
References: <dadd07f9ed693d6bcf541764b62a2caf4cc38630.1402353627.git.marcel@ziswiler.com>
 <95c131deb3e410e8defc9fe125dc662bdb276310.1402353627.git.marcel@ziswiler.com>
Message-ID: <539A0357.6070403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2014 04:52 PM, Marcel Ziswiler wrote:
> This patch adds the device tree to support Toradex Apalis T30, a
> computer on module which can be used on different carrier boards.

This looks OK; I'll apply once the merge window is done.

> diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts

> +	pwmleds {
...
> +		pwm3 {
> +		pwm2 {
> +		pwm1 {

Those still aren't sorted. I'll try and remember to fix that when I
apply it.
