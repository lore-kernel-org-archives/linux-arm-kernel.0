From: shijie8@gmail.com (Huang Shijie)
Date: Fri, 6 Apr 2012 15:40:53 +0800
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120404122335.GD17187@pengutronix.de>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
 <CAMiH66EC7=x0sRYhE3hpEyBemDGSRS19xguQUqKj2kuPw5Tifw@mail.gmail.com>
 <20120404122335.GD17187@pengutronix.de>
Message-ID: <CAMiH66GM0RxP-z=HNkOhhPaaXCZLKPvWFy=_+aGbbGSdrsg+iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:

On Wed, Apr 4, 2012 at 8:23 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi,
>
>> Could you provide an API such as gpmi_reset_block()?
>> It will much helpful to me.
>
> Ah, that's what you meant in the other thread. Well, this can be added
> later. My suggestion
>
> 1) get this mainline to remove mach dependencies
> 2) convert the drivers
> 3) do proper timeout mechanisms
> 4) add features
>
> where 2-4 can probably happen more or less simultaneously.
I wish you could send out the new patch as soon as possible. :)

Best Regards
Huang Shijie



>
> Regards,
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
> iEYEARECAAYFAk98PUcACgkQD27XaX1/VRvkOQCdGqBQAgDeW5xpykbKe4LTlqXA
> twIAnA+IivcJwTQsnrPSjLJWTNlFAULt
> =01hN
> -----END PGP SIGNATURE-----
>
