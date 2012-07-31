From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 14:53:37 +0100
Subject: [PATCH 17/19] Documentation: Define the MOP500 Audio Machine
 Driver Device Tree bindings
In-Reply-To: <1343741953-17828-18-git-send-email-lee.jones@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
 <1343741953-17828-18-git-send-email-lee.jones@linaro.org>
Message-ID: <20120731135337.GM4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 02:39:11PM +0100, Lee Jones wrote:

> +Required properties:
> + - compatible                : "stericsson,snd-soc-mop500"

> +Non-standard properties:
> + - Machine Driver:
> +   - stericsson,cpu-dai      : Phandle to the CPU-side DAI
> +   - stericsson,audio-codec  : Phandle to the Audio CODEC

You should also support the card name property (there's a helper to
parse it, you can define the name of the property though) so apps can
tell what board they're on.
