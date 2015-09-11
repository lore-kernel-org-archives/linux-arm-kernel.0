From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Sep 2015 22:36 +0200
Subject: [PATCH v2 1/9] dmaengine: st_fdma: Add STMicroelectronics FDMA DT
 binding documentation
In-Reply-To: <1441980871-24475-2-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <51503956.PMFrWKUjxX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 September 2015 15:14:23 Peter Griffin wrote:
> +- st,fdma-id	: Must contain fdma controller number

What for?
> +Example:
> +
> +	fdma1: fdma-app at 8e40000 {

The name should be "dma-controller", not "fdma-app".

> +Example:
> +
> +	snd_uni_player2: snd-uni-player at 2 {
> +		compatible = "st,snd_uni_player";

Maybe change the compatible string to "st,snd-uni-player"?

The string you use here would not be acceptable for a binding.

	Arnd
