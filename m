From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 12 May 2010 09:15:58 +0200
Subject: [GIT PULL] pxa: patches for .35 merge window (34-rc7 based)
In-Reply-To: <201005120130.55329.marek.vasut@gmail.com>
References: <AANLkTimOqaAfg7QtoTBuV3ofVFnFIMHWHSx4L8aFWc1r@mail.gmail.com>
	<201005120130.55329.marek.vasut@gmail.com>
Message-ID: <AANLkTikqR5sFBU-QjxevOujp9hJ9i3zfNY-ACDQGwrNr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 1:30 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne ?t 11. kv?tna 2010 17:34:49 Eric Miao napsal(a):
>> The following changes since commit
>> b57f95a38233a2e73b679bea4a5453a1cc2a1cc9: Linus Torvalds (1):
>> ? ? ? ? Linux 2.6.34-rc7
>>
>> are available in the git repository at:
>>
>> ? git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
>> devel
>>
>> Eric Miao (17):
>> ? ? ? input: remove now deprecated corgi_ts.c touchscreen driver
>> ? ? ? [ARM] pxa: remove now un-used corgi_ssp.c and corgi_lcd.c
>> ? ? ? [ARM] pxa: remove the now legacy SSP API
>> ? ? ? [ARM] pxa: correct SSCR0_SCR to support multiple SoCs
>> ? ? ? [ARM] pxa: merge regs-ssp.h into ssp.h
>> ? ? ? [ARM] pxa: remove unnecessary #include of <mach/ssp.h>
>> ? ? ? [ARM] pxa: remove incorrect select PXA_SSP in Kconfig
>> ? ? ? [ARM] pxa: add MFP_LPM_KEEP_OUTPUT flag to pin config
>> ? ? ? [ARM] pxa: allow keypad GPIOs to wakeup when configured as generic
>> ? ? ? [ARM] pxa: allow MFP_LPM_INPUT to be explicitly specified
>> ? ? ? [ARM] pxa/spitz: use generic GPIO API and remove pxa_gpio_mode()
>> ? ? ? [ARM] pxa/corgi: use generic GPIO API and remove pxa_gpio_mode()
>> ? ? ? [ARM] pxa/corgi: cleanup GPIO configurations and low power mode
>> settings [ARM] pxa/tosa: move CONFIG_KEYBOARD_TOSA_USE_EXT_KEYCODES to
>> mach/Kconfig input: remove obsolete {corgi,spitz,tosa}kbd.c
>> ? ? ? [ARM] pxa: remove pxa_gpio_mode() and files
>> ? ? ? [ARM] pxa: make it clear by converting MMC 'delay_detect' to
>> millisecond
>>
>> Haojian Zhuang (13):
>> ? ? ? [ARM] pxa: move ssp into common plat-pxa
>> ? ? ? [ARM] pxa: simplify ifdef in ssp.h
>> ? ? ? [ARM] mmp: support ssp in pxa168
>> ? ? ? [ARM] mmp: enable ssp in aspenite
>> ? ? ? [ARM] mmp: update clock register function
>> ? ? ? [ARM] mmp: enable L2 in mmp2
>> ? ? ? [ARM] mmp: update mmp2 defconfig
>> ? ? ? [ARM] mmp: configure gpio pins from 128 to 192
>> ? ? ? [ARM] mmp: update mfp setting
>> ? ? ? [ARM] mmp: add dma support to mmp2
>> ? ? ? [ARM] mmp: update twsi index
>> ? ? ? [ARM] mmp: append device support in jasper
>> ? ? ? [ARM] pxa: add namespace on ssp
>>
>> Igor Grinberg (5):
>> ? ? ? [ARM] pxa/cm-x300.c: add battery charger support
>> ? ? ? [ARM] pxa/cm-x300: da903x WLED is not connected on cm-x300
>> ? ? ? [ARM] pxa/cm-x300: fix da903x IRQ line assignment
>> ? ? ? [ARM] pxa/cm-x300: add regulator on vcc_core
>> ? ? ? [ARM] pxa/cm-x300: update the memory fixup.
>>
>> Julia Lawall (2):
>> ? ? ? [ARM] pxa: avoid NULL dereferencing in error handling of ssp.c
>> ? ? ? [ARM] pxa: use resource_size() in ssp.c
>>
>> Marek (1):
>> ? ? ? [ARM] pxa: add basic support for Voipac PXA270 SBC
>>
>> Marek Vasut (11):
>> ? ? ? [ARM] pxa: add basic support for the Aeronix Zipit Z2 handheld
>> ? ? ? [ARM] pxa: add support for Voipac PXA270 PCMCIA
>> ? ? ? [ARM] pxa/vpac270: UDC and UHC support
>> ? ? ? [ARM] pxa/vpac270: add ethernet support
>> ? ? ? [ARM] pxa/vpac270: Add touchscreen support
>> ? ? ? [ARM] pxa/vpac270: Add DS1339 RTC support
>> ? ? ? [ARM] pxa/vpac270: add ide support
>> ? ? ? [ARM] pxa/vpac270: remove TS_IRQ magic number
>> ? ? ? [ARM] pxa/vpac270: add OneNAND support
>> ? ? ? [ARM] pxa/vpac270: fix now invalid bit of UP2OCR
>> ? ? ? MAINTAINERS: New MAINTAINERS entries for Zipit Z2 and Voipac PXA270
>>
> The's me ... twice ;-)
>

That's the author field, and is normally copied from the "From:" field,
so make sure you get it correct in the first place. I intend to keep the
branch intact since the git pull is sent.
