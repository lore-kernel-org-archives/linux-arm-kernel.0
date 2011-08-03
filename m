From: koen.beel.barco@gmail.com (Koen Beel)
Date: Wed, 3 Aug 2011 14:00:26 +0200
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <20110803103710.GA1948@pengutronix.de>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>
	<20110721215020.GA25344@pengutronix.de>
	<4E28EEE1.2050008@freescale.com>
	<20110722055731.GI26837@S2100-06.ap.freescale.net>
	<4E292FCF.6010608@freescale.com>
	<CAHMSPgMHrqWcJ=BThDLgQ=XyTBDCMvNS4SVjQWfk=Jf682TEig@mail.gmail.com>
	<4E2F6F90.7030207@freescale.com>
	<CAHMSPgPC4whyskfuFGeFd7WHx-=5htezWajm_rNi9Xa+03PV0A@mail.gmail.com>
	<20018.24364.787244.956361@ipc1.ka-ro>
	<CAHMSPgM5W8=mE4sRDGMMfo39fvThBo_jrdG8hyhJNQ_ceV=_pA@mail.gmail.com>
	<20110803103710.GA1948@pengutronix.de>
Message-ID: <CAHMSPgOQc2JGrNm8qPo+E-U-fwkgd=3Rhq9qUn5unqa7J_8mVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 3, 2011 at 12:37 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> > Do you have an SD card in the system? I'm getting the same error when
>> > accessing an SD card. Without SD card I can use the flash without any
>> > errors.
>>
>> No SD card in the system. At least not on my mx23evk board.
>> My real target hardware has a SDIO wifi chip.
>
> Removing the SD didn't help here as well. Koen, which bootloader do you
> use?

i'm using uboot in nand flash.
(build an sb file containing power_prep, boot_prep and uboot en
flashed to nand using kobs-ng tool)

In my setup uboot loads a uImage from tftp. This uImage contains the
full rootfs as initramfs. So no need for mmc, nfs or nand.

If someone would like to try using my uImage for mx23evk, you can
download it here:
https://www.transferbigfiles.com/025d4f2a-38da-266a-66d1-1d7a05b1b938?rid=J3Qh9b7Vb1ORXFtzU589fw%3d%3d

Regards,
Koen


>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk45JNYACgkQD27XaX1/VRt1hACdFt1CQltiTWSwcoaNXsmJqkS0
> ycQAn3oPqxZYK/wmtd5S9Gh5dj+5YM73
> =jJs2
> -----END PGP SIGNATURE-----
>
>
