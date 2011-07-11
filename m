From: shijie8@gmail.com (Huang Shijie)
Date: Mon, 11 Jul 2011 11:19:11 -0400
Subject: [PATCH v7 0/4] add the GPMI-NAND support for imx23/imx28
In-Reply-To: <20110711110024.GB11153@pengutronix.de>
References: <1310371266-10704-1-git-send-email-b32955@freescale.com>
	<20110711110024.GB11153@pengutronix.de>
Message-ID: <CAMiH66G4T3y=JydxFCaDwBZwHBvayy1i+Ys5Hd2+f-_u7bPoGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:

On Mon, Jul 11, 2011 at 7:00 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi,
>
> On Mon, Jul 11, 2011 at 04:01:02PM +0800, Huang Shijie wrote:
>
>> The general-purpose media interface(GPMI) controller is a flexible interface
>> to up to several NAND flashs.
>>
>> The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.
>>
>> With the help of BCH, the GPMI controller can choose to do the hardware ECC or
>> not.
>>
>> v6 --> v7:
>> ? ? ? [0] rename RES_SIZE to GPMI_NAND_RES_SIZE.
>> ? ? ? [1] move gpmi-nand.h to `include/linux/mtd/` directory.
>> ? ? ? [2] remove comment for new pad control.
>> ? ? ? [3] others
>
> Could you also post a driver which is adapted to all these changes?
> The series looks good now; still I want to test it a little just to make
> sure...
ok.

I will sent out the GPMI driver as soon as possible.


Best Regards
Huang Shijie

>
> Thanks,
>
> ? Wolfram
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk4a18gACgkQD27XaX1/VRsCUQCfeXzR64/uz3n97nbdrTGxH86+
> 3lUAmweRWjZlouL+9cdGiuu8gz4CzNhH
> =CQJw
> -----END PGP SIGNATURE-----
>
>
