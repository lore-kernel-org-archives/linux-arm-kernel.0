From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 15 Dec 2009 14:54:42 +0000
Subject: [PATCH 3/4] regulator: add voltage selection capability to
	mc13783 regulators v2 .
In-Reply-To: <1260811598.2022.144.camel@climbing-alby>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<1260811085.2022.135.camel@climbing-alby>
	<1260811598.2022.144.camel@climbing-alby>
Message-ID: <1260888882.3591.559.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-14 at 18:26 +0100, Alberto Panizzo wrote:
> This patch, complete the mc13783 regulator subsystem driver with 
> voltage selecting capability.
> Main Switches (SW1AB, SW2AB) are not supported yet.
> 
> version 2 diffs:
> - delete the "Switchers PLL" enable and multiplication factor value 
>   selecting capability because it is not a voltage or current regulator.
>   This will be a part of Main switcher supporting task.
> - Correct many coding style problems pointed me out.
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/regulator/mc13783-regulator.c |  345 ++++++++++++++++++++++++++++++---
>  1 files changed, 315 insertions(+), 30 deletions(-)

Applied.

Thanks

Liam
