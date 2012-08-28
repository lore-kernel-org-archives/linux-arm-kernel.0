From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Aug 2012 14:22:41 -0300
Subject: [PATCH v2 1/2] ARM: clk-imx35: Fix SSI clock registration
In-Reply-To: <20120828171320.GE4534@opensource.wolfsonmicro.com>
References: <1345466362-2576-1-git-send-email-fabio.estevam@freescale.com>
 <20120822192723.GS7995@opensource.wolfsonmicro.com>
 <CAOMZO5B2feJzbqEQgJm_gKDcZPSKuckXWj=s+b+5R39Tnv7-kw@mail.gmail.com>
 <20120828171320.GE4534@opensource.wolfsonmicro.com>
Message-ID: <CAOMZO5CnEFHfw5iCW0vqwLHOwqdyuWzb_dtVqF5QLD3rjFAShQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 2:13 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

>> Did imx_ssi_probe go successfully? What is the error log you are getting?
>
> The controller probes but there's no perceptible activity on the pins
> when we try to reset the CODEC so no register I/O.

Take a look at pcm043_ac97_cold_reset/pcm043_ac97_warm_reset at
arch/arm/mach-imx/mach-pcm043.c
to see how GPIO pins are handled for resetting ac97 codec on this platform.

Regards,

Fabio Estevam
