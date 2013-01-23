From: liu.y.victor@gmail.com (Liu Ying)
Date: Wed, 23 Jan 2013 22:23:21 +0800
Subject: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
In-Reply-To: <20130123141445.GA2758@pengutronix.de>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
 <20130123125001.GG16264@pengutronix.de>
 <CA+8Hj80=Mk1gMSC9gcRT_XPFrEdRxifaB9FNMtkn3BkUkv9bGA@mail.gmail.com>
 <20130123134936.GH16264@pengutronix.de>
 <CA+8Hj83n+pC+a6bYOOH1b61DTqSjpKsxyKDgDL2pCRKxTq4EXg@mail.gmail.com>
 <20130123141445.GA2758@pengutronix.de>
Message-ID: <CA+8Hj81NmS5KZp+0NRSgKMHyGueDhQw51DjuA_3s7x50F5GJFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/23 Wolfram Sang <w.sang@pengutronix.de>:
>
>> The names of the two entries are not the same, one is "24c512", the
>> other is "24c512b".
>
> I do understand that. There are TONS of 24c512 variants out there.
>
>> My original idea to add the new entry is to count on the name
>> difference to do different system reset operations.
>
> Your devicetree may have both names, but at24 doesn't need it since
> there is no code involved handling the difference.
>
>> The commit message of the patch which adds 24c32 support for MX28EVK
>> tells that "mx28evk has a free slot U50 that can be used to populate
>> an I2C EEPROM.".
>
> I do know that, too. You can put other things there, too. But well, not
> worth the hazzle...

I accept your comments on this patch. Thanks for your review!

>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAlD/8FUACgkQD27XaX1/VRsmGgCeJZCaByj0gw37lr753wxW0npY
> 06oAn0WAmYiUabRNgQ6eAmcO7Ky3f1U4
> =JSKP
> -----END PGP SIGNATURE-----
>



-- 
Best Regards,
Liu Ying
