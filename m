From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 22:56:19 -0700
Subject: [GIT PULL] ARM: at91: DT for 4.13
In-Reply-To: <20170616162608.ucjxtqpvjhdj77gy@piout.net>
References: <20170616162608.ucjxtqpvjhdj77gy@piout.net>
Message-ID: <20170619055619.GO7703@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 06:26:08PM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here is the DT pull request, switching most platform the the new EBI and
> NAND bindings.
> 
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.13-dt
> 
> for you to fetch changes up to bc03ce08396786c92d6591a81682c7da7accbfc8:
> 
>   ARM: dts: at91: sama5d2_xplained: remove wrong memory node (2017-06-08 23:49:17 +0200)
> 
> ----------------------------------------------------------------
> DT for 4.13
> 
>  - Switch to the new NAND binding
>  - A few non urgent fixes
> 
> ----------------------------------------------------------------
> Baruch Siach (1):
>       ARM: dts: at91: sama5d2_xplained: remove wrong memory node
> 
> Boris Brezillon (4):
>       dt-bindings: mtd: atmel-nand: Document the nfc-io bindings
>       ARM: dts: at91: Declare EBI/NAND controllers
>       ARM: dts: at91: Switch to the new NAND bindings
>       ARM: dts: at91: Add the NOR flash available on sama5d3 dev kits
> 
> Claudiu Beznea (1):
>       ARM: dts: at91: sama5d2_xplained: add pwm controller
> 
> Javier Martinez Canillas (1):
>       ARM: dts: at91: Add generic compatible string for I2C EEPROM
> 
> Uwe Kleine-K?nig (2):
>       dts: gpio_atmel: adapt binding doc to reality
>       ARM: dts: at91-sama5d4: use IRQ_TYPE_* to specify irq flags
> 
> Wenyou Yang (1):
>       ARM: dts: at91: sama5d2: add m_can nodes

Merged, thanks.


-Olof
