From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 May 2014 12:37:55 -0600
Subject: [PATCH v2 3/3] ARM: tegra: initial add of Colibri T30
In-Reply-To: <a8f01e573dcb7d563833ddcda30567e8ac7626ed.1400103181.git.stefan@agner.ch>
References: <cover.1400103181.git.stefan@agner.ch>
 <a8f01e573dcb7d563833ddcda30567e8ac7626ed.1400103181.git.stefan@agner.ch>
Message-ID: <53750983.3080705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 03:45 PM, stefan at agner.ch wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> This patch adds the device tree to support Toradex Colibri T30, a
> computer on module which can be used on different carrier boards.
> 
> The module consists of a Tegra 30 SoC, two PMIC, DDR3L RAM, eMMC,
> a LM95245 temperature sensor and an AX88772B USB Ethernet
> Controller. Furthermore, there is a STMPE811 and SGTL5000 audio
> codec which are not yet supported. Anything that is not self
> contained on the module is disabled by default.
> 
> The device tree for the Evaluation Board includes the modules
> device tree and enables the supported pheripherials of the carrier
> board (the Evaluation Board supports almost all of them).

I've applied this to Tegra's for-3.16/dt branch.

A changelog in each individual patch would be useful. Splitting out
patches for the DRM tree and the Tegra tree into different series would
be useful. In this case, they don't depend on each-other.
